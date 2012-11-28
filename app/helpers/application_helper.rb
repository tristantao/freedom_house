module ApplicationHelper

  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
  def highlight_whole_word(text, phrases, *args)
    options = args.extract_options!
    unless args.empty?
      ActiveSupport::Deprecation.warn "Calling highlight with a highlighter as an argument is deprecated. " \
      "Please call with :highlighter => '#{args[0]}' instead.", caller

      options[:highlighter] = args[0] || '<strong class="highlight">\1</strong>'
    end
    options.reverse_merge!(:highlighter => '<strong class="highlight">\1</strong>')

    text = sanitize(text) unless options[:sanitize] == false
    if text.blank? || phrases.blank?
      text
    else
      #Edited highlight from Ruby::ActionView::Helper::TextHelper such that it only matches whole words (i.e. didn't bold THE in There)
      match = Array(phrases).map { |p| '[\s[[:punct:]]]' + Regexp.escape(p) + '[\s[[:punct:]]]' }.join('|')
      text.gsub(/(#{match})(?![^<]*?>)/i, options[:highlighter])
    end.html_safe
  end

end
