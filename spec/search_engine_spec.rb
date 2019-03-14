require 'spec_helper'

RSpec.describe SearchEngine do
  let(:json_data) { File.read('spec/fixtures/users.json') }
  let(:filename) { File.basename(json_data, '.json') }

  let(:search_engine) { SearchEngine.new(repository: data_repository) }

  let(:result_data_1) do
    [
      {
        "_id"=>1,
        "active"=>true,
        "name"=>"Francisca Rasmussen",
        "organization_id"=>119,
        "signature"=>"",
        "tags"=>["Springville", "Sutton", "Hartsville/Hartley"],
        "role"=>"admin"
      }
    ]
  end

  context 'when search value is found' do
    let(:data_repository) do
      DataRepository.new(source: json_data, source_name: filename)
    end

    it 'returns matched data' do
      search_result =
        search_engine.search(search_field: "name", search_value: "Francisca Rasmussen")

      expect(search_result).to eq(result_data_1)
    end
  end

  context 'when search value is not found' do
    let(:data_repository) do
      DataRepository.new(source: json_data, source_name: filename)
    end

    it 'returns empty data' do
      search_result =
        search_engine.search(search_field: "name", search_value: "Franc")

      expect(search_result).to eq([])
    end
  end

  context 'when search value is an empty value' do
    let(:data_repository) do
      DataRepository.new(source: json_data, source_name: filename)
    end

    it 'returns matched data' do
      search_result =
        search_engine.search(search_field: "signature", search_value: "")

      expect(search_result).to eq(result_data_1)
    end
  end

  context 'when search value is within result array' do
    let(:data_repository) do
      DataRepository.new(source: json_data, source_name: filename)
    end

    it 'returns matched data' do
      search_result =
        search_engine.search(search_field: "tags", search_value: "Springville")

      expect(search_result).to eq(result_data_1)
    end
  end

  context 'when searching for a boolean value' do
    let(:data_repository) do
      DataRepository.new(source: json_data, source_name: filename)
    end

    it 'returns matched data with boolean value' do
      search_result =
        search_engine.search(search_field: "active", search_value: "true")

        expect(search_result).to eq(result_data_1)
    end
  end

  context 'when searching for an integer value' do
    let(:data_repository) do
      DataRepository.new(source: json_data, source_name: filename)
    end

    it 'returns matched data with integer value' do
      search_result =
        search_engine.search(search_field: "_id", search_value: "1")

        expect(search_result).to eq(result_data_1)
    end
  end

  context 'when search field is invalid' do
    let(:data_repository) do
      DataRepository.new(source: json_data, source_name: filename)
    end

    it 'raises InvalidSearchField error' do
      expect {
        search_engine.search(search_field: "invalid_field", search_value: "1")
      }.to raise_error(SearchEngine::InvalidSearchField)
    end
  end
end
