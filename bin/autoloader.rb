# coding:UTF-8
require 'rubygems'
require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'fileutils'

Capybara.register_driver :selenium_chrome do |app|
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.timeout = 500
  Capybara::Selenium::Driver.new(app, :browser => :chrome, :http_client => client)
end

Capybara.javascript_driver = :selenium_chrome#:chrome
Capybara.run_server = true
Capybara.current_driver = :selenium_chrome
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
      click_button('Войти')
    end

    def doubleclick(word)
        element = page.find(".x-grid3-body",:text => "#{word}")
        page.driver.browser.mouse.double_click(element.native)   
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

    def check_if_grey(word, counter, log_var)
      sleep 2
      if page.evaluate_script("$('.detached_word').css('color')") == "rgb(0, 0, 0)"
        puts "#{word} - серые!!!!!!!!!!!"
        log_var <<"#{counter}: #{word} - СЕРЫЕ!!!!!!!!!!!"<<"\n"
        sleep 1
      end
    end

    def exists(word)
      page.evaluate_script("$('body').find('div#ext-gen495.x-grid3-body').text()") == "#{word}"
    end

    def does_not_exist(word)
      page.evaluate_script("$('body').find('div#ext-gen495.x-grid3-body').text()") != "#{word}"
    end

    def check_existance(word, counter, log_var)
      variable=0
      30.times do
        if page.evaluate_script("$('body').find('td.x-grid3-col.x-grid3-cell.x-grid3-td-word.x-grid3-cell-first').text()") == "#{word}"
          doubleclick("#{word}")
          break
        else
          sleep 1
          variable+=1
          puts variable
        end
        if variable==30
          puts "#{word} - нет в ките!!!!!!!!!!!"
          log_var <<"#{counter}: #{word} - НЕТ В КИТЕ!!!!!!!!!!!"<<"\n"        
          return "Does not exist"                
        end
      end
    end

    def not_avaliable(word)
      page.evaluate_script("$('body').find('.ext-el-mask').text()") == "#{word}"

    end



    def resize_window(width, height)
      page.driver.browser.manage.window.resize_to(width.to_i,height.to_i)
    end

    def waiting_for_string_after(string_before_val)
      variable =0


      60.times do
        sleep 1
        variable+=1
        puts variable
        string_after = page.all('span.ytb-text')[2].text
        break if string_after != string_before_val 
        if variable == 60
          return "Does not load"
        end
      end 
    end
  def wait_until
    loop do
     sleep 0.1
     
     if true
      break
    end
    end
    

  end

    def test_kit
      resize_window(1920,976)
      time = Time.now.utc.localtime
      timenow = time.strftime("logs-%d-%m-%Y-%H-%M-%S")
      
      File.open("/home/koryushka/projects/autoload/logs/#{timenow}.txt", 'a') do |log|
        begin
        visit('/')
        puts "Kirill or Liza?(K/L)"
        name = gets.chomp!
        if name == "K"
          log_in('karetnikov', 'yib45zeh')
        elsif name == "L"
          log_in('potapova', 'goz27neb')
        else
          redo
        end

       # login = page.find_by_id('ext-comp-1003').native
        #login.send_keys("ankor")
       # password = page.find_by_id('ext-comp-1004').native
       # password.send_keys("karinaankor")
        #page.execute_script("$('#ext-comp-1003').val('ankor')")
        #page.evaluate_script("$('#ext-comp-1004').val('karinaankorankor')")
        t = 0
        loop do
          t +=1 
          puts t
          sleep 1
          break if page.evaluate_script("$('#ext-gen57.ext-el-mask').css('display')") =="none"
        end
        
        click_link 'Ключевые слова'
        i = 0
        puts "Выбрать файл с заданием: 1 или 2 ?"
        file = gets.chomp
        if file == "1"
          task = "задание"
        elsif file == "2"
          task = "задание2"
        else
          nil
        end
          
                

          File.open("/home/koryushka/projects/autoload/task/#{task}.txt", ).each do |x|
          i+=1
          fill_in('keyword', with: "#{x}")
          puts "#{i}: #{x}"
          click_button 'Применить'
                 
          
          next if check_if_grey("#{x.chomp}", i, log)
          var = 0
          10.times do 
            if exists("#{x.chomp}") and !not_avaliable("#{x.chomp}")
              doubleclick("#{x.chomp}")
              break
            elsif not_avaliable("#{x.chomp}")
              sleep 1
              var+=1
              puts "Wait for clicable element: #{var}"
              if var==10
                puts "#{x.chomp} - НЕ ЗАГРУЖЕНО!!!!"
                log<< "#{i}: #{x} - НЕ ЗАГРУЖЕНО!!!!!!!!"<<"\n" 
                next
              end  
          
            else
              nil
            end
          end
          
          if does_not_exist("#{x.chomp}")
            if check_existance("#{x.chomp}", i, log) == "Does not exist"
              next
            end  
          end          
           variable_a=0
           5.times do
            if page.find_link('Ссылки').visible? == false
              sleep 1
              doubleclick("#{x.chomp}")
              variable_a+=1
              puts "waiting for double clicking #{variable_a}"
             end   
           end

        

          wait_until{page.find_link('Ссылки').visible?}
          click_link('Ссылки')

          sleep 1

          wait_until{page.all('span.ytb-text')[2].visible?}
          
          wait_until{page.find_button('Добавить список текстов').visible?}
          click_button('Добавить список текстов')
          content = File.open("/home/koryushka/projects/autoload/words/#{x.chomp}.txt").read()
          content.gsub!("\r","\r\n")
          wait_until{page.find_field('texts').visible?}
          #page.evaluate_script("$('texts').val('#{content}')")
          fill_in 'texts', :with => content
          string_before = page.all('span.ytb-text')[2].text
          click_button('Добавить')
         
          if waiting_for_string_after(string_before) == "Does not load"   #
            puts "#{x.chomp} - НЕ ЗАГРУЖЕНО!!!!"
            log<< "#{i}: #{x} - НЕ ЗАГРУЖЕНО!!!!!!!!" << "\n"
            click_button('Отмена') if page.find_button('Отмена').visible?
            click_button('Закрыть')
            next

          end
 
          
          string_after = page.all('span.ytb-text')[2].text
          puts string_before
          puts string_after
          
          click_button('Закрыть')
          sleep 1
          resulting_string = "                                        #{result('EC',string_before,string_after)} #{result('LC',string_before,string_after)} #{result('IC',string_before,string_after)}"
          string_for_log = case
            when resulting_string == "                                        10 EC  " then "10%"
            when resulting_string == "                                        15 EC 15 LC " then "15%"  
            when resulting_string == "                                        20 EC 5 LC 5 IC" then "20%"  
            when resulting_string == "                                        20 EC 19 LC " then "25 - without IC%" 
            when resulting_string == "                                        25 EC 7 LC 7 IC" then "25%"   
            when resulting_string == "                                        30 EC 20 LC 10 IC" then "30%"    
            when resulting_string == "                                        30 EC 30 LC " then "30 - without IC%"     
            when resulting_string == "                                        45 EC 30 LC 20 IC" then "45%"  
            when resulting_string == "                                        45 EC 50 LC " then "45 - without IC%"    
            when resulting_string == "                                        50 EC 35 LC 20 IC" then "50%"    
            when resulting_string == "                                        50 EC 55 LC " then "50% - without IC"   
            when resulting_string == "                                        75 EC 40 LC 25 IC" then "75%"  
            when resulting_string == "                                        90 EC 90 LC " then "100% - without IC"   
            when resulting_string == "                                        100 EC 50 LC 30 IC" then "100%"    
          else
              "Attention" 
          end 
          log <<"#{i}: #{x}"
          if "#{result('EC',string_before,string_after)} #{result('LC',string_before,string_after)} #{result('IC',string_before,string_after)}".gsub(" ",'') == ""
            log << "          НЕ ЗАГРУЖЕНО!!!!" << "\n"
          else
            log << "                                        #{result('EC',string_before,string_after)} #{result('LC',string_before,string_after)} #{result('IC',string_before,string_after)}" << "  -  #{string_for_log}"<< "\n"
          end
        end


          log << "Total: #{i}"
                rescue Interrupt
          log << "Total: #{i.to_i-1}"
        end
      end 
    end
  end
end  
    
  


t = MyCapybaraTest::Test.new
t.test_kit
