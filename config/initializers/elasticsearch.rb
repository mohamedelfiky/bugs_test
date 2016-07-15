yaml_path = "#{ Rails.root }/config/elasticsearch.yml"
ELASTIC_CONFIG = YAML.load_file(yaml_path)[Rails.env].symbolize_keys!

Elasticsearch::Model.client = Elasticsearch::Client.new(ELASTIC_CONFIG)
