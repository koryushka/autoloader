# coding:UTF-8
require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'fileutils'



Capybara.javascript_driver = :firefox
Capybara.run_server = false
Capybara.current_driver = :selenium
Capybara.app_host = 'http://kit.kokoc.com/kit/#keywords'
Capybara.default_wait_time = 500



  module MyCapybaraTest
  class Test
      include Selenium::WebDriver
      include Capybara::DSL
      def fill(selector, value)
        page.execute_script %Q(
                          var input = $('#{selector}');
                          input.val('#{value}')
                         )
end

    def log_in(login,password)
      
      fill_in 'loginUsername', with: login
      fill_in 'loginPassword', :with =>password
      sleep 2
      click_button('Login')
    end

    def doubleclick#(word)
        #element = page.find(".x-grid3-body",:text => "#{word}", :disabled=> false)
        page.execute_script("$('.x-grid3-body[1]').dblclick()")  
        page.execute_script("$('.x-grid3-body[0]').dblclick()") 
        page.execute_script("$('.x-grid3-body[2]').dblclick()") 
      
    end

    def result(el,string_before,string_after)
      if string_before.include?("#{el}")
        value_before = string_before[/[\d+\s]+#{el}/]
      else
        value_before = "0#{el}"
      end

      if string_after.include?("#{el}")
        value_after = string_after[/[\d+\s]+#{el}/]
      else
        value_after = "0#{el}"
      end
      final_value = value_after.gsub("#{el}",'').to_i - value_before.gsub("#{el}",'').to_i
      if final_value != 0
        "#{final_value} #{el}"
      else
        nil
      end
    end

    def test_kit
      page.driver.browser.manage.window.resize_to(1920,976)
      time = Time.now.utc.localtime
      File.open("/home/koryushka/projects/autoload/logs/logs.txt-#{time}", 'a') do |log|
        visit('/')
        #fill('ext-comp-1003', 'hellosssssssssss')
        log_in('ankor', 'karinaankor')
        #page.evaluate_script("$('#ext-comp-1003').text() == 'hellosssssssssss'")
        sleep 10
        click_link 'Ключевые слова'
        i = 0
        File.open("/home/koryushka/projects/autoload/task/задание.txt", ).each do |x|
          i+=1
          fill_in('keyword', with: "#{x}")
          click_button 'Применить'

         
           sleep 2
           if page.evaluate_script("$('.detached_word').css('color')") == "rgb(0, 0, 0)"
            puts "#{x.chomp} - серые!!!!!!!!!!!"
            next
          end

          doubleclick#("#{x.chomp}")

          wait_until{page.find_link('Ссылки').visible?}
          click_link('Ссылки')
          sleep 1
          wait_until{page.all('span.ytb-text')[4].visible?}
          string_before = page.all('span.ytb-text')[4].text
          wait_until{page.find_button('Добавить список текстов').visible?}
          click_button('Добавить список текстов')
          content = File.open("/home/koryushka/projects/autoload/words/#{x.chomp}.txt").read()
          content.gsub!("\r","\r\n")
          wait_until{page.find_field('texts').visible?}
          fill_in 'texts', :with => content
         # wait_until{page.find_button('Добавить').visible?}
          click_button('Добавить')
         
          
            loop do
              sleep 1
              string_after = page.all('span.ytb-text')[4].text
              break if string_before != string_after  
              #break if string_before != string_after
            end  
          
          string_after = page.all('span.ytb-text')[4].text
          puts string_before
          puts string_after
          
          click_button('Закрыть')
          sleep 1
          log <<"#{i}: #{x}"
          if "#{result('EC',string_before,string_after)} #{result('LC',string_before,string_after)} #{result('IC',string_before,string_after)}".gsub(" ",'') == ""
            log << "          НЕ ЗАГРУЖЕНО!!!!" << "\n"
          else
            log << "          #{result('EC',string_before,string_after)} #{result('LC',string_before,string_after)} #{result('IC',string_before,string_after)}" << "\n"
          end
        end
        log << "Total: #{i}"
      end 
    end
  end
end
  
    
  


t = MyCapybaraTest::Test.new
t.test_kit