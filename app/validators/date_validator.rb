class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value > DateTime.parse("january 1, 1970")
      record.errors[attribute] << (options[:message] || "Date cant be before year 1970")
    end
  end
end

