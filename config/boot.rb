require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])


require 'rails/commands/server'
module Rails
  class Server
    alias :default_options_alias :default_options
    def default_options
      default_options_alias.merge!(:Port => 3010)
    end    
  end
end




# <b> Thanks for your valuable feedback ! <br>
#  Save this Token Number for further communications  <%= Feedback.last.token %></b>

# <%= link_to 'Add a new Feedback', new_feedback_path %> 
# <%= link_to 'Wait for Doc Response!', root_path %>
