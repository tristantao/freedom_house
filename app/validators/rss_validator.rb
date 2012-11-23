require 'open-uri'

class RssValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.nil? then
      doc = Nokogiri::HTML(open(value))
      if doc.xpath('/html/body/rss[@version]').empty?
        record.errors[attribute] << (options[:message] || "is not a valid RSS feed!")
      end
    #else
    #  record.errors[attribute] << (options[:message] || "can't be blank.")
    end  
  end
end

