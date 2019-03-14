require_relative 'search/data_repository'
require_relative 'search/search_engine'
require_relative 'search/zendesk_search'
require_relative 'search/search_value_types/boolean'
require_relative 'search/search_value_types/integer'
require_relative 'search/search_value_types/converter'
require_relative 'search/commands/get_search_value'
require_relative 'search/commands/list_filenames'
require_relative 'search/commands/load_all_fields'
require_relative 'search/commands/search'

module Search
  DATA_DIR = File.join(File.dirname(File.expand_path('.', __dir__)), 'data', '*')
end
