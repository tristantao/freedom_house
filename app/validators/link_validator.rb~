require 'open-uri'

class LinkValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if /^https?:\/\//.match(value).nil?
<<<<<<< HEAD
      record.errors[attribute] << (options[:message] || "must begin with \'http(s)://\'")
=======
      record.errors[attr_name] << (options[:message] || "must begin with \'http(s)://\'.")
>>>>>>> 424f92d2871fbe9f8933d6d54db43e81f7b1f7f0
    end
    begin
    doc = Nokogiri::HTML(open(value))
    rescue URI::InvalidURIError
<<<<<<< HEAD
      record.errors[attribute] << (options[:message] || 'is incorrectly formatted')
    rescue => e
      record.errors[attribute] << (options[:message] || e.message)
=======
      record.errors[atttr_name] << (options[:message] || 'is incorrectly formatted.')
      record.errors.add(attr_name, :email, options.merge(:value => value))
    rescue => e
      record.errors[attr_name] << (options[:message] || e.message)
      record.errors.add(attr_name, :email, options.merge(:value => value))
>>>>>>> 424f92d2871fbe9f8933d6d54db43e81f7b1f7f0
    end
  end
end

