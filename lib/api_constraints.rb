# Handles API versioning through HTTP Accept header
class ApiConstraints
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(req)
    header_value = "application/vnd.instabug.api.v#{ @version }"
    @default || req.headers['Accept'].try(:include?, header_value)
  end
end
