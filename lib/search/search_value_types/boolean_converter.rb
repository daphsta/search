module SearchValueTypes
  class BooleanConverter
    def convert(value)
      return unless %w(true false).include?(value)
      value.downcase.to_s == 'true'
    end
  end
end
