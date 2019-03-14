require 'spec_helper'

RSpec.describe Commands::GetSearchValue do
  describe '#call' do
    let(:prompter) { double('prompter', ask: true) }

    it 'prompts for search value' do
      Commands::GetSearchValue.call(prompter: prompter, search_field: 'field')

      expect(prompter).to have_received(:ask)
    end
  end
end
