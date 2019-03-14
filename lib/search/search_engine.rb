class SearchEngine
  class InvalidSearchField < StandardError; end

  attr_reader :repository

  def initialize(repository:)
    @repository = repository
  end

  def search(search_field:, search_value:)
    raise InvalidSearchField, "#{search_field} is not valid for searching" if !ensure_search_field_valid(search_field)

    converted_search_value = [ SearchValueTypes::Converter.call(search_value: search_value) ]

    repository.fetch_all.select do |hash_data|
      next unless hash_data.has_key?(search_field)

      matched_value = hash_data[search_field]

      find_value_in_nested(matched_value, converted_search_value)
    end
  end

  private

  def find_value_in_nested(matched_value, converted_search_value)
    if matched_value.is_a?(Array)
      matched_value.any? { |v| converted_search_value.include?(v) }
    else
      converted_search_value.include?(matched_value)
    end
  end

  def ensure_search_field_valid(search_field)
    repository.list_all_fields.include?(search_field)
  end
end
