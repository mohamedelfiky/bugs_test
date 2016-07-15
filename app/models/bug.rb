class Bug < ActiveRecord::Base
  include Searchable
  after_destroy :decrement_bugs_count

  has_one :state, dependent: :destroy

  validates :application_token, :status, :priority, presence: :true
  validates :number, uniqueness: { scope: :application_token }

  enum status: { new_bug: 0, in_progress: 1, closed: 2 }
  enum priority: { minor: 0, major: 1, critical: 2 }

  accepts_nested_attributes_for :state
  default_scope { includes(:state) }

  # define mapping for elastic search
  settings ELASTIC_CONFIG[:custom_analyzer] do
    mappings dynamic: 'false' do
      keywords = Bug.column_names - %w(comment)

      keywords.each do |field|
        indexes field, analyzer: 'keyword', include_in_all: true
      end
      indexes :comment, analyzer: 'edge_nGram_analyzer', search_analyzer: 'whitespace_analyzer', include_in_all: true
    end
  end

  def self.count_by_application(application)
    redis_key = "#{ application }_bugs_count"
    count = Redis.current.get(redis_key)

    # update bugs count if cache is empty
    if count.nil?
      count = Bug.where(application_token: application).count
      Redis.current.set(redis_key, count)
    end
    count
  end

  def self.filter(number, application_token)
    redis_key = "#{ application_token }_#{ number }"

    # search in redis in case of worker doesn't reach this record yet
    bug = Redis.current.get(redis_key)
    if bug.nil?
      Bug.find_by!(number: number, application_token: application_token)
    else
      Bug.new(JSON.parse(bug))
    end
  end

  def push_to_worker
    increment_bugs_count
    redis_key = "#{ application_token }_#{ number }"
    if valid?
      Redis.current.set(redis_key, json_attributes)
      BugsWorker.perform_async(redis_key)
    end
    valid?
  end

  # define increment_bugs_count and decrement_bugs_count
  %i(increment decrement).each do |method_name|
    define_method("#{ method_name }_bugs_count".to_sym) do
      redis_key = "#{ application_token }_bugs_count"
      count = (method_name == :increment) ? Redis.current.incr(redis_key) : Redis.current.decr(redis_key)
      self.number = count if method_name == :increment
      Redis.current.set(redis_key, count)
      count
    end
  end

  def json_attributes
    attributes.merge(state_attributes: state.attributes).to_json
  end
end
