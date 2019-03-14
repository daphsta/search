require 'spec_helper'

RSpec.describe SearchValueTypes::Boolean do
  describe '#match?' do
    context 'when value is boolean string' do
      it 'returns true' do
        result = SearchValueTypes::Boolean.new("true")

        expect(result.match?).to eq true
      end
    end

    context 'when value is not boolean string' do
      it 'returns false' do
        result = SearchValueTypes::Boolean.new("name")

        expect(result.match?).to eq false
      end
    end
  end

  describe '#convert' do
    context 'when value is boolean string' do
      it 'converts to TrueClass value' do
        result = SearchValueTypes::Boolean.new("true")

        expect(result.convert).to eq true
      end

      it 'converts to FalseClass value' do
        result = SearchValueTypes::Boolean.new("false")

        expect(result.convert).to eq false

      end
    end

    context 'when value is not boolean string' do
      it 'raises an error' do
        result = SearchValueTypes::Boolean.new("2")

        expect {
          result.convert
        }.to raise_error(TypeError)
      end
    end
  end
end
