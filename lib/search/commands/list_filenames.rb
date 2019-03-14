module Commands
  class ListFilenames
    def self.call(prompter:)
      new(prompter).call
    end

    attr_reader :prompter

    def initialize(prompter)
      @prompter = prompter
    end

    def call
      return prompter.warn(
        "Ensure JSON files are loaded into the data directory of this application"
      ) if filenames.empty?

      prompter.select("Select to search from") do |menu|
        filenames.each do |filename|
          menu.choice "#{filename.capitalize}", filename
        end
      end
    end

    private

    def filenames
      files.map { |f| File.basename(f, '.json') }
    end

    def files
      Dir.glob(::Search::DATA_DIR)
    end
  end
end
