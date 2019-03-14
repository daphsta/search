module SearchValueTypes
  class Converter
    TYPE_FINDER = [
      Boolean,
      Integer
    ].freeze

    attr_reader :search_value

    def self.call(search_value:)
      new(search_value).call
    end

    def initialize(search_value)
      @search_value = search_value
    end

    def call
      instantiated_finder_classes = TYPE_FINDER.map { |t| t.new(search_value) }
      converter_class = instantiated_finder_classes.detect do |t|
        t.match?
      end

      return search_value.to_s if converter_class.nil?

      converter_class.convert
    end
  end
end
