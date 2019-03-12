require_relative 'search/data_repository'
require_relative 'search/search_engine'
require_relative 'search/zendesk_search'
require_relative 'search/search_value_types/boolean_converter'
require_relative 'search/search_value_types/integer_converter'
require_relative 'search/search_value_types/string_converter'
require_relative 'search/search_value_types/converter'

module Search
  DATA_DIR = File.join(File.dirname(File.expand_path('.', __dir__)), 'data', '*')
end
