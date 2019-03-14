require 'spec_helper'

RSpec.describe Commands::Search do
  let(:repository) { double('repository') }
  let(:prompter) { double('prompter', say: true, ok: true, warn: true) }

  describe '#call' do
    context 'when all variables are valid' do
      let(:search_engine) { double('search_engine', search: [name: 'zendesk']) }

      it 'returns a search result' do
        allow(SearchEngine).to receive(:new).and_return(search_engine)

        Commands::Search.call(
          prompter: prompter,
          repository: repository,
          search_value: 'zendesk',
          search_field: 'name'
        )

        expect(prompter).to have_received(:say).with(
          JSON.pretty_generate([{"name": "zendesk" }])
        )

        expect(prompter)
          .to have_received(:ok)
          .with("\n1 result(s) found \n")
      end
    end

    context 'when search value is empty' do
      let(:search_engine) { double('search_engine', search: []) }

      it 'returns no results' do
        allow(SearchEngine).to receive(:new).and_return(search_engine)

        Commands::Search.call(
          prompter: prompter,
          repository: repository,
          search_value: '',
          search_field: 'name'
        )

        expect(prompter).to have_received(:warn).with("No results found")
      end
    end

    context 'when search field is empty' do
      let(:search_engine) { double('search_engine', search: []) }

      it 'outputs a warning' do
        allow(SearchEngine).to receive(:new).and_return(search_engine)

        Commands::Search.call(
          prompter: prompter,
          repository: repository,
          search_value: '',
          search_field: 'name'
        )

        expect(prompter).to have_received(:warn).with("No results found")
      end
    end

    context 'when search field is invalid' do
      it 'outputs a warning' do
        allow(SearchEngine).to receive(:new).and_raise(SearchEngine::InvalidSearchField)

        Commands::Search.call(
          prompter: prompter,
          repository: repository,
          search_value: '',
          search_field: 'name'
        )

        expect(prompter).to have_received(:warn)
      end
    end
  end
end
