# coding:UTF-8
require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'fileutils'

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.javascript_driver = :chrome
Capybara.run_server = true
Capybara.current_driver = :selenium_chrome
Capybara.app_host = 'http://kit.kokoc.com/kit/#keywords'
Capybara.default_wait_time = 50


module MyCapybaraTest

  class Test
      include Selenium::WebDriver
      include Capybara::DSL

    
    def test_kit
      File.open("/home/koryushka/projects/autoload/logs/logs.txt",'w') {|x| x.puts}
      File.open("/home/koryushka/projects/autoload/logs/logs.txt", 'a') do |log|
      visit('/')
      fill_in('loginUsername', with: "ankor") 
      fill_in 'loginPassword', :with =>"karinaankor"
      sleep 2
        click_button('Login')
      
      using_wait_time(30) do
      	click_link 'Ключевые слова'
      end
      i = 0
      File.open("/home/koryushka/projects/autoload/задание.txt", ).each do |x|
        i+=1
        fill_in('keyword', with: "#{x}")
        click_button 'Применить'
        sleep 2
       # page.all(".x-grid3-body")[1].click()
        word2 = page.find(".x-grid3-body",:text => "#{x.chomp}")
       # page.driver.browser.mouse.click(word2.native)
        #page.driver.browser.mouse.click(word2.native)
       # page.driver.browser.mouse.double_click(word2.native)
        page.driver.browser.mouse.double_click(word2.native)


        #doubleClick(word)
        sleep 2
          click_link('Ссылки')
        sleep 2
        string_before = page.all('span.ytb-text')[4].text
        click_button('Добавить список текстов')
        sleep 2
        content = File.open("/home/koryushka/projects/autoload/words/#{x.chomp!}.txt").read()

        content.gsub!("\r","\r\n")

       fill_in 'texts', :with => content
        click_button('Добавить')
       sleep 2
        string_after = page.all('span.ytb-text')[4].text
        click_button('Закрыть')
        log << "#{i}: #{x}" << "\n"
        #print"#{result('EC')} #{result('LC')} #{result('IC')} "
        log << string_before << "\n"
        log << string_after << "\n"
      end
       
      log << "Total: #{i}"
      


    end 
    end

    def result(el)
      if @string_before.include?("#{el}")
        value_before = string_before[/[\d]+#{el}/]
      else
        value_before = "0#{el}"
      end

      if @string_after.include?("#{el}")
        value_after = string_after[/[\d]+#{el}/]
      else
        value_after = "0#{el}"
      end
      final_value = value_after.gsub("#{el}",'').to_i - value_before.gsub("#{el}",'').to_i
      "#{final_value} #{el}"

    end
  end
end

t = MyCapybaraTest::Test.new
t.test_kit