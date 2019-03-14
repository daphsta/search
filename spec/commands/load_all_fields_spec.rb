require 'spec_helper'

RSpec.describe Commands::LoadAllFields do
  before do
    allow(Dir).to receive(:glob).and_return(
      ['test_path/test_users.json', 'test_path/test_tickets.json']
    )
  end

  let(:prompter) { double('prompter', select: true, warn: true) }

  describe '#call' do
    context 'when valid filename is provided' do
      let(:filename) { 'test_users' }
      let(:repo) { double('repo', list_all_fields: ['id', 'name']) }

      it 'renders a menu of all fields' do
        allow(File).to receive(:open).and_yield('user')
        allow(DataRepository).to receive(:new).and_return(repo)

        command = Commands::LoadAllFields.new(prompter: prompter, filename: filename)

        command.call

        expect(prompter).to have_received(:select)
      end
    end

    context 'when no filename is provided' do
      let(:filename) { '' }

      it 'outputs a warning message' do
        command = Commands::LoadAllFields.new(prompter: prompter, filename: filename)

        command.call

        expect(prompter).to have_received(:warn)
      end
    end

    context 'when inexistent filename is provided' do
      let(:filename) { 'invalid_json_file.json' }

      it 'outputs a warning message' do
        command = Commands::LoadAllFields.new(prompter: prompter, filename: filename)

        command.call

        expect(prompter).to have_received(:warn)
      end
    end
  end

  describe '#data_repository' do
    context 'when a valid filename is provided' do
      let(:filename) { 'test_users' }
      let(:repo) { double('repo', list_all_fields: ['id', 'name']) }

      it 'instantiates the data repository' do
        allow(File).to receive(:open).and_yield('user')
        allow(DataRepository).to receive(:new).and_return(repo)

        command = Commands::LoadAllFields.new(prompter: prompter, filename: filename)

        command.call

        expect(DataRepository)
          .to have_received(:new)
          .with(source: 'user', source_name: filename)
      end
    end
  end
end
