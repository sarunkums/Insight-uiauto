require 'spec_helper.rb'

describe "Login --" do
  it "should login to prime insight" do
    on_page(LoginPage) do |page|
      page.navigate_to $url
      page.login_with @pc_server['app_username'], @pc_server['app_password']
    end
    
  end
end

#describe "Invalid Login --" do
#  it "should not login to prime insight" do
#    on_page(LoginPage) do |page|
#      page.navigate_to $url
#      page.login_with @pc_server['app_username'], @pc_server['app_password']
#      page.errorDiv_element.when_present(30)
#      page.errorDiv_element.text.include? "Invalid Username or Password.Please try again."
#    end
#  end
#end