module Commands
  class GetSearchValue
    def self.call(prompter:, search_field:)
      new(prompter, search_field).call
    end

    attr_reader :prompter, :search_field

    def initialize(prompter, search_field)
      @prompter = prompter
      @search_field = search_field
    end

    def call
      prompter.ask("Type here to search #{search_field}", convert: :string)
    end
  end
end
