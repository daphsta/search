module Commands
  class UnknownFile < StandardError; end

  class LoadAllFields
    attr_reader :prompter, :filename, :data_repository

    def initialize(prompter:, filename:)
      @prompter = prompter
      @filename = filename
    end

    def call
      file = File.read(selected_filepath)
      @data_repository = DataRepository.new(source: file, source_name: filename)

      render_fields_menu(data_repository.list_all_fields)

    rescue UnknownFile => e
      prompter.warn e.message
    rescue Errno::ENOENT => e
      prompter.warn e.message
    rescue TypeError => e
      prompter.warn e.message
    end

    private

    def selected_filepath
      raise UnknownFile, "No file selected for search" if filename.empty?

      files.detect { |f| /#{filename}/.match(f) }
    end

    def render_fields_menu(all_fields)
      prompter.select("Select field to search") do |menu|
        all_fields.each do |field|
          menu.choice "#{field}", field
        end
      end
    end

    def files
      Dir.glob(::Search::DATA_DIR)
    end
  end
end
