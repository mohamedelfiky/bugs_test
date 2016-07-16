require 'elasticsearch/model'

module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks
    index_name [Rails.env, base_class.to_s.pluralize.underscore].join('_')

    def self.search(q)
      query = {
        multi_match: {
          query: q,
          type: :cross_fields,
          fields: column_names
        }
      }
      Elasticsearch::Model.search({ query: query }, self).per(10)
    end
  end
end
