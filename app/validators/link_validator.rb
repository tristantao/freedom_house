require 'open-uri'

class LinkValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if /^https?:\/\//.match(value).nil?
      record.errors[attribute] << (options[:message] || "must begin with \'http(s)://\'")
    end
    begin
    doc = Nokogiri::HTML(open(value))
    rescue URI::InvalidURIError
      record.errors[attribute] << (options[:message] || 'is incorrectly formatted')
    rescue => e
      record.errors[attribute] << (options[:message] || e.message)
    rescue => e
    end
  end
end

