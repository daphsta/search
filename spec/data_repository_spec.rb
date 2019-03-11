require 'spec_helper'

RSpec.describe DataRepository do
  let(:result_data_array) do
    [
      {
        "_id"=>1,
        "active"=>true,
        "name"=>"Francisca Rasmussen",
        "organization_id"=>119,
        "signature"=>"",
        "tags"=>["Springville", "Sutton", "Hartsville/Hartley"],
        "role"=>"admin"
      },

      {
        "_id"=>2,
        "name"=>"Cross Barlow",
        "active"=>false,
        "signature"=>"Don't Worry Be Happy!",
        "organization_id"=>106,
        "tags"=>[
          "Foxworth",
          "Woodlands",
          "Herlong"
        ],
        "role"=>"admin"
      }
    ]
  end

  let(:result_single_data) do
    [
      {
        "_id"=>1,
        "name"=>"Charley",
        "active"=>true,
        "signature"=>"",
        "organization_id"=>121,
        "tags"=>["Springville", "Sutton", "Hartsville/Hartley"],
        "role"=>"admin"
      }
    ]
  end

  let(:malformed_data) { "id=> 1" }
  let(:valid_file) { File.read('spec/fixtures/users.json') }
  let(:valid_filename) { File.basename(valid_file, '.json') }

  describe '#fetch_all' do
    context 'when data is an array' do
      let(:repo) { DataRepository.new(source: valid_file, source_name: valid_filename) }

      it 'returns an array of data' do
        expect(repo.fetch_all).to eq(result_data_array)
      end
    end

    context 'when data is a hash' do
      let(:repo) do
        file = File.read('spec/fixtures/user.json')
        filename = File.basename(file, '.json')

        DataRepository.new(source: file, source_name: filename)
      end

      it 'returns an array of data' do
        expect(repo.fetch_all).to eq(result_single_data)
      end
    end

    context 'when data is malformed' do
      let(:repo) do
        file = File.read('spec/fixtures/malformed.json')
        filename = File.basename(file, '.json')

        DataRepository.new(source: file, source_name: filename)
      end

      it 'raises an error' do
        expect {
          repo.fetch_all
        }.to raise_error(TypeError)
      end
    end
  end

  describe '#list_all_fields' do
    context 'when provided data is valid' do
      let(:repo) { DataRepository.new(source: valid_file, source_name: valid_filename) }

      it 'returns a list of all unique keys' do
        expect(repo.list_all_fields).to eq(
          [
            "_id", "active", "name", "organization_id", "role", "signature", "tags"
          ]
        )
      end
    end
  end
end
