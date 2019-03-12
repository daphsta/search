require 'tty-prompt'

class ZendeskSearch
  attr_reader :prompter

  def initialize
    @prompter = TTY::Prompt.new
  end

  def load_prompts
    load_welcome_prompt

    loop do
      load_quit_prompt
      selected_search_file = load_search_files_menu
      selected_file_path = find_selected_file(selected_search_file)
      selected_search_field = load_all_search_fields(selected_file_path)
      search_value = load_search_value_menu(selected_search_field)

      search_engine = SearchEngine.new(repository: repo)
      result = search_engine.search(search_field: selected_search_field, search_value: search_value)
      render_result(result)
    end

  rescue TTY::Reader::InputInterrupt
    prompter.say("\n Goodbye!")
  end

  private

  attr_reader :repo

  def load_welcome_prompt
    prompter.say "Welcome to Zendesk Search. Type 'q' to quit anytime"
  end

  def load_quit_prompt
    prompter.on(:keypress) do |event|
      if event.value == 'q'
        prompter.say "\n Goodbye!"
        exit
      end
    end
  end

  def load_search_files_menu
    prompter.select("Select to search from") do |menu|
      filenames.each do |filename|
        menu.choice "#{filename.capitalize}", filename
      end
    end
  end

  def find_selected_file(filename)
    files.detect { |f| /#{filename}/.match(f) }
  end

  def load_all_search_fields(file_path)
    file = File.read(file_path)
    filename = File.basename(file, '.json')

    @repo = DataRepository.new(source: file, source_name: filename)
    render_fields_menu(repo.list_all_fields)

  rescue Errno::ENOENT, TypeError
    prompter.say 'Something has gone wrong with the selected file'
  end

  def load_search_value_menu(selected_field)
    prompter.ask("Type here to search #{selected_field}", convert: :string)
  end

  def render_result(result)
    return prompter.say("No results found") if result.empty?

    prompter.say(JSON.pretty_generate(result))
  end

  def filenames
    files.map { |f| File.basename(f, '.json') }
  end

  def render_fields_menu(all_fields)
    prompter.select("Select field to search") do |menu|
      all_fields.each do |field|
        menu.choice "#{field}", field
      end
    end
  end

  def files
    Dir.glob(Search::DATA_DIR)
  end
end
