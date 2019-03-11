require 'json'
require 'set'

class DataRepository
  attr_reader :source, :source_name, :data

  def initialize(source:, source_name:)
    @source = source
    @data = {}
    load
  end

  def fetch_all
    data.values.flatten
  end

  def list_all_fields
    data[source_name].reduce(Set.new) do |all_fields, data|
      all_fields.merge(data.keys)
    end.map(&:to_s).sort
  end

  private

  def load
    json_data = JSON.parse(source)
    data[source_name] = to_array(json_data)
  end

  def to_array(source_data)
    case source_data
    when Array then source_data
    when Hash then [ source_data ]
    else
      raise TypeError, 'The data provided is malformed'
    end
  end
end
