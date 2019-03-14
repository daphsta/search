require 'spec_helper'

RSpec.describe SearchValueTypes::Converter do
  describe '#call' do
    context 'when search value is boolean' do
      it 'returns a Boolean value' do
        result = SearchValueTypes::Converter.call(search_value: 'true')

        expect(result).to eq(true)
      end
    end

    context 'when search value is integer' do
      it 'returns an Integer value' do
        result = SearchValueTypes::Converter.call(search_value: '1')

        expect(result).to eq(1)
      end
    end

    context 'when search value is string' do

      it 'returns a String value' do
        result = SearchValueTypes::Converter.call(search_value: 'name')

        expect(result).to eq('name')
      end
    end
  end
end
