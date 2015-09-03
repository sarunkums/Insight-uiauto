class LoginPage

  include PageObject
  $login_ajax_counter=0

  div(:headerRight,:class =>"headerRight")
  div(:settingLoginLabel){headerRight_element.div(:class=>"dijitInline settingLoginLabel")}

  td(:logoutDiv,:id =>'logout_text')

  span(:refresh,:class=>'dijitReset dijitInline toolbarIcon refreshToolbarIcon')
  span(:OKbutton,:text=>'OK')
  text_field(:userName,:id =>'loginPage_username')
  text_field(:password,:id =>'loginPage_password')
  span(:loginButton,:id =>'loginPage_LoginButton_label')

  def initialize_page
  end

  def enterCredentials(username, password)
    begin
      $login_ajax_counter=$login_ajax_counter+1
      #self.userName = username
      @browser.text_field(:id=>'loginPage_username').send_keys username
      sleep 1
      #self.password = password
      @browser.text_field(:id => 'loginPage_password').send_keys password
      sleep 1
      puts "--USERNAME ->#{@browser.text_field(:id => 'loginPage_username').value}"
      puts "--PASSWORD ->#{@browser.text_field(:id => 'loginPage_password').value}"
      if(@browser.text_field(:id => 'loginPage_username').value!=username or @browser.text_field(:id => 'loginPage_password').value!=password)
        if($login_ajax_counter>10)
          raise "--Login unsuccessful after 10 attempts since expected username and password could not be set in textfields--"
        else
          sleep 3
          puts "-User Name and  Password not entered correctly due to ajax calls... Retrying after 2 seconds..."
          enterCredentials username,password
        end
      else
        sleep 1
        loginButton_element.when_present(30).click
      end
    rescue
      raise "Unable to login to Prime Collaboration"
    end
  end

  #  def watirErrorCheck(username,password)
  #    if(@browser.div(:text=>'Password is required').present? or @browser.div(:text=>'Username is required').present? or @browser.div(:text=>'Invalid Username or Password. Please try again.').present?)
  #      @browser.span(:class=>'dijitReset dijitInline xwt-TextButtonNode').click
  #      sleep 1
  #      enterCredentials username, password
  #    end
  #  end

  def login_with(username, password)
    if(@browser.text_field(:id => 'loginPage_username').present? and @browser.text_field(:id => 'loginPage_password').present?)
      puts 'Username Password textfields Present on the page...'
      enterCredentials username, password
      #watirErrorCheck  username, password  ###This method is used to check overcome WATIR login without entering the username/password in the text fields
    else
      puts 'Could not find Username Password textfields...Sleeping for 10 seconds and retrying...'
      sleep 10
      enterCredentials username, password
      #watirErrorCheck  username, password
    end
  end

  def refreshPage
    refresh_element.when_present(60).click
    sleep(10)

  end

  #  def logout
  #    logoutDiv_element.when_present(30)
  #    logoutDiv
  #  end

  def logoutFromPC

    self.settingLoginLabel_element.when_present(3).click
    self.logoutDiv_element.when_present(3).click

  end

  def close_browser
    @browser.close
  end

end