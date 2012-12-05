require 'open-uri'

class LinkValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    if /^https?:\/\//.match(value).nil?
      record.errors[attr_name] << (options[:message] || "must begin with \'http(s)://\'.")
    end
    begin
    doc = Nokogiri::HTML(open(value))
    rescue URI::InvalidURIError
      record.errors[atttr_name] << (options[:message] || 'is incorrectly formatted.')
      record.errors.add(attr_name, :email, options.merge(:value => value))
    rescue => e
      record.errors[attr_name] << (options[:message] || e.message)
      record.errors.add(attr_name, :email, options.merge(:value => value))
    end
  end
end

