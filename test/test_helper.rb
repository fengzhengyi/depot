ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_as(user)
    if respond_to? :visit
      visit login_url
      fill_in :name,with: user.name
      fill_in :password, with: user.password
      click_on 'Login'
    end

    def logout
      delete logout_url
    end

    def setup
      login_as users(:one)
    end
  end
end
