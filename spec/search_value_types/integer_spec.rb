require 'spec_helper'

RSpec.describe SearchValueTypes::Integer do
  describe '#match?' do
    context 'when value is an integer string' do
      it 'returns true' do
        result = SearchValueTypes::Integer.new("1")

        expect(result.match?).to eq true
      end
    end

    context 'when value is not an integer string' do
      it 'returns false' do
        result = SearchValueTypes::Integer.new("name")

        expect(result.match?).to eq false
      end
    end
  end

  describe '#convert' do
    context 'when value is an integer string' do
      it 'converts to an Integer value' do
        result = SearchValueTypes::Integer.new("1")

        expect(result.convert).to eq 1
      end
    end

    context 'when value is not an integer string' do
      it 'raises an error' do
        result = SearchValueTypes::Integer.new("true")

        expect {
          result.convert
        }.to raise_error(TypeError)
      end
    end
  end
end
