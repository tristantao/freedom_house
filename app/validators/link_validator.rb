class LinkValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /https?:\/\/(''|www\.).*\..*/i
      record.errors[attribute] << (options[:message] || "must begin with http(s)://(www.)")
    end
  end
end
