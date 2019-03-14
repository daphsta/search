module SearchValueTypes
  class Integer
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def match?
      value.to_i.to_s == value
    end

    def convert
      raise TypeError, 'Cannot convert value' unless match?
      
      value.to_i
    end
  end
end
