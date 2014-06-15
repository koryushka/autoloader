# coding:UTF-8
require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

Capybara.run_server = false
Capybara.current_driver = :selenium
Capybara.app_host = 'http://0.0.0.0:3000'
module MyCapybaraTest

  class Test
    
      include Selenium::WebDriver
      include Capybara::DSL

    
    def test_kit
      visit('/')
    color = page.evaluate_script("$('.container').find('#logo').css('color')")
    puts color
    end


    
  end
end

t = MyCapybaraTest::Test.new
t.test_kit