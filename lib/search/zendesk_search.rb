require 'tty-prompt'

class ZendeskSearch
  attr_reader :prompter

  def initialize
    @prompter = TTY::Prompt.new
  end

  def load_prompts
    loop do
      load_welcome_prompt
      load_quit_prompt

      selected_filename = Commands::ListFilenames.call(prompter: prompter)
      all_fields_command = Commands::LoadAllFields.new(
        prompter: prompter, filename: selected_filename
      )

      selected_search_field = all_fields_command.call

      search_value = Commands::GetSearchValue.call(
        prompter: prompter, search_field: selected_search_field
      )

      Commands::Search.call(
        prompter: prompter,
        repository: all_fields_command.data_repository,
        search_value: search_value,
        search_field: selected_search_field
      )
    end

  rescue TTY::Reader::InputInterrupt
    prompter.say("\n Goodbye!")
  end

  private

  def load_welcome_prompt
    prompter.say "\nWelcome to Zendesk Search. Type 'q' to quit anytime\n"
  end

  def load_quit_prompt
    prompter.on(:keypress) do |event|
      if event.value == 'q'
        prompter.say "\n Goodbye!"
        exit
      end
    end
  end
end
