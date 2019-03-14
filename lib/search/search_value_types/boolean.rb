module SearchValueTypes
  class Boolean
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def match?
      %w(true false).include?(value)
    end

    def convert
      raise TypeError, 'Cannot convert value' unless match?

      value.downcase.to_s == 'true'
    end
  end
end
