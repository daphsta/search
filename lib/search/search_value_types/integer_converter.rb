module SearchValueTypes
  class IntegerConverter
    def convert(value)
      return unless value.to_i.to_s == value
      value.to_i
    end
  end
end
