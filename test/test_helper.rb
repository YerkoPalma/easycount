ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
  include FactoryGirl::Syntax::Methods

  def is_logged_in?
    !session[:user_id].nil?
  end
  
  # Logs in a test user.
  def log_in_as(user, options = {})
    password    = options[:password]    || 'password'
    
    if integration_test?
      post sessions_path, session: { email:       user.email,
                                  password:    password }
    else
      session[:user_id] = user.id
    end
  end
  
  private

    # Returns true inside an integration test.
    def integration_test?
      defined?(post_via_redirect)
    end
end
