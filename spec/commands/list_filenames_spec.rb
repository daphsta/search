require 'spec_helper'

RSpec.describe Commands::ListFilenames do
  describe '#call' do
    context 'when filenames do not exist' do
      let(:prompter) { double('prompter', warn: true) }

      it 'returns an error message' do
        allow(Dir).to receive(:glob).and_return([])

        Commands::ListFilenames.call(prompter: prompter)

        expect(prompter).to have_received(:warn)
      end
    end

    context 'when filenames exists' do
      let(:prompter) { double('prompter', select: true) }

      it 'returns a select menu' do
        allow(Dir).to receive(:glob).and_return(['file1.json'])

        Commands::ListFilenames.call(prompter: prompter)

        expect(prompter).to have_received(:select)
      end
    end
  end
end
