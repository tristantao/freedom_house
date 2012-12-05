require 'open-uri'

class RssValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.nil? || attribute.nil?
      record.errors[attribute] << (options[:message] || "can't be blank")
    else
      if /https?:\/\//.match(value).nil?
        record.errors[attribute] << (options[:message] || 'must begin with \'http(s)://\'')
      else
        begin
        doc = Nokogiri::HTML(open(value))
        rescue URI::InvalidURIError
          record.errors[attribute] << (options[:message] || 'is incorrectly formatted.')
        rescue => e
          record.errors[attribute] << (options[:message] || e.message)
        else
          if doc.xpath('/html/body/rss[@version]').empty?
            record.errors[attribute] << (options[:message] || 'is not a valid RSS feed')
          end
        end
      end
    end
  end
end

