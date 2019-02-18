ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!


class ActiveSupport::TestCase
  fixtures :all

  setup do
    OmniAuth.config.test_mode = true
  end
  
  teardown do
    OmniAuth.config.test_mode = false
  end
  
  def login(user)
    OmniAuth.config.add_mock(:twitter, { uid: user.uid })
    get '/auth/twitter'
    request.env['omniauth.env'] = OmniAuth.config.mock_auth[:twitter]
    get '/auth/twitter/callback'
  end
  
  def logout
    delete '/logout'
  end
  
end