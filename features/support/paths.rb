# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the admin dashboard$/ then '/admin'
    when /^the home page$/ then '/'
    when /^the users page$/ then '/admin/users'
    when /^the sources page$/ then '/admin/sources'
    when /^the add user page$/ then '/admin/users/new'
    when /^the add source page$/ then '/admin/sources/new'
    when /^the add event page$/ then '/admin/events/new'
    when /^the scraper page$/ then '/admin/webscraper'
    when /^the articles page$/ then '/admin/articles'
    when /^the admin feedback page$/ then '/admin/feedbacks'
    when /^the non-admin feedback page$/ then '/feedbacks'
    when /^the accept_reject page$/ then '/admin/webscraper/accept_reject'
    when /^the classifier page$/ then '/admin/webscraper'

    when /^the edit user page for "(.*)"/
      id = User.find_by_email($1).id
      "/admin/users/edit/#{id}"
    when /^the edit source page for "(.*)"/
      id = Source.find_by_name($1).id
      "/admin/sources/edit/#{id}"
    when /^the edit event page for "(.*)"/
      id = Event.find_by_name($1).id
      "/admin/events/edit/#{id}"
    when /^the login page$/ then '/login'
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
