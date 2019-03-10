module SearchValueTypes
  class Converter
    TYPE_FINDER = [
      BooleanConverter.new,
      IntegerConverter.new,
      StringConverter.new
    ].freeze

    attr_reader :search_value

    def self.call(search_value)
      new(search_value).call
    end

    def initialize(search_value)
      @search_value = search_value
    end

    def call
      converted_value = []

      TYPE_FINDER.each do |converter_class|
        converted_value << converter_class.convert(search_value)
      end

      converted_value.compact.first
    end
  end
end
