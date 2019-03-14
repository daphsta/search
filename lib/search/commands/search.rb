module Commands
  class Search
    def self.call(prompter:, repository:, search_value:, search_field:)
      new(prompter, repository, search_value, search_field).call
    end

    attr_reader :prompter, :repository, :search_value, :search_field

    def initialize(prompter, repository, search_value, search_field)
      @prompter = prompter
      @repository = repository
      @search_value = search_value
      @search_field = search_field
    end

    def call
      search_engine = SearchEngine.new(repository: repository)
      result = search_engine.search(
        search_field: search_field,
        search_value: search_value
      )
      render_result(result)

      rescue SearchEngine::InvalidSearchField => e
        prompter.warn(e.message)
    end

    private

    def render_result(result)
      return prompter.warn("No results found") if result.empty?

      prompter.say(JSON.pretty_generate(result))
      prompter.ok("\n#{result.size} result(s) found \n")
    end
  end
end
