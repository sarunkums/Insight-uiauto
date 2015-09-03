require './spec/spec_helper.rb'

describe "US6457-UserManagement" do

  before :all do
    visit UsermanagementPage
  end

  it "should be able to Verify User Management UI::Tny1632389c" do

    on UsermanagementPage do |page|
      page.page_title.should be == "User Management"
    end

  end

  it "should be able to Verify Add User::Tny1632390c" do

    content = on_page(UsermanagementPage).add_user
    content.should be_true

  end

  it "should be able to verify Edit User::Tny1632391c" do
    content = on_page(UsermanagementPage).updated_user
    content.should be_true
  end

  it "should be able to Verify the Quick Filter option::Tny1632393c" do
    content = on_page(UsermanagementPage).quick_filter
    content.should be_true
  end

  it "should be able to verify Delete User::Tny1632392c" do
    content = on_page(UsermanagementPage).delete_user
    content.should be_true
  end

  it "should be able to Verify the All Filter option::Tny1632394c" do
    content = on_page(UsermanagementPage).all_filter
    content.should be_true
  end

  it "should be able to Verify the Duplicate User::Tny1632402c" do
    content = on_page(UsermanagementPage).dublicate_user
    content.should be_true
  end

  it "should be able to Verify mandatory fields in User form::Tny1632403c" do	##Regression TestCase modified
    content = on_page(UsermanagementPage).mandatory_fields
    content.should be_true
  end

  it "should be able to Verify Add User Roles selection::Tny1632404c" do
    content = on_page(UsermanagementPage).user_role
    content.should be_true
  end

  it "should be able to verify user management row selection::Tny1632658c" do
    content = on_page(UsermanagementPage).tablerow_selection
    content.should be_true
  end

  it "should be able to Verify column Add  ::Tny1632395c " do
    content = on_page(UsermanagementPage).add_colum
    content.should be_true

  end

  it "should be able to Verify column  Reset ::Tny1632396c" do
    content = on_page(UsermanagementPage).reset_colum
    content.should be_true

  end

  it "should be able to Verify the User created with only Report Viewer role ::Tny1632399c" do
    on UsermanagementPage do |page|
      page.viewer_user
      page.toggleIcon_element.should be_present
    end
  end
end

describe "US19044- UserManagement -UI" do

  before :all do
    visit UsermanagementPage
  end

  it "should be able to Verify username validation - alphanumeric characters::Tny1853690c" do

    on UsermanagementPage do |action|
      unamearg1 ="Testusr_01"
      pwdarg1   ="Testpwd_01"
      rpwdarg1  ="Testpwd_01"
      expect(action.usernameValid(unamearg1,pwdarg1,rpwdarg1)).to be_true
      unamearg2 ="testusr"
      pwdarg2   ="Testpwd_01"
      rpwdarg2  ="Testpwd_01"
      expect(action.usernameInValid(unamearg2,pwdarg2,rpwdarg2)).to be_true
    end
  end

  it "should be able to Verify username validation - minimum and max length::Tny1853691c" do
    on UsermanagementPage do |action|
      unamearg1 ="UName_length-lessthan24c"
      pwdarg1   ="Testpwd_01"
      rpwdarg1  ="Testpwd_01"
      expect(action.usernameValid(unamearg1,pwdarg1,rpwdarg1)).to be_true
      unamearg2 ="UName_length-morethan24ch"
      pwdarg2   ="Testpwd_01"
      rpwdarg2  ="Testpwd_01"
      expect(action.usernameInValid(unamearg2,pwdarg2,rpwdarg2)).to be_true
    end
  end

  it "should be able to Verify username validation - allowed spl characters::Tny1853692c" do
    on UsermanagementPage do |action|
      unamearg ="UName_with-vld spl.char"
      pwdarg   ="Testpwd_01"
      rpwdarg  ="Testpwd_01"
      expect(action.usernameValid(unamearg,pwdarg,rpwdarg)).to be_true
    end
  end

  it "should be able to Verify username validation - with non allowed spl characters::Tny1853693c" do
    on UsermanagementPage do |action|
      unamearg ="UName@invld(spl)*char#"
      pwdarg   ="Testpwd_01"
      rpwdarg  ="Testpwd_01"
      expect(action.usernameInValid(unamearg,pwdarg,rpwdarg)).to be_true
    end
  end

  it "should be able to Verify password validation for min and max length::Tny1853696c" do
    on UsermanagementPage do |action|
      unamearg1 ="Testusr_02"
      pwdarg1   ="Test#1"
      rpwdarg1  ="Test#1"
      expect(action.usernameInValid(unamearg1,pwdarg1,rpwdarg1)).to be_true
      unamearg2 ="Testusr_03"
      pwdarg2   ="Test@Password_More#Lenght"
      rpwdarg2   ="Test@Password_More#Lenght"
      expect(action.usernameInValid(unamearg2,pwdarg2,rpwdarg2)).to be_true
    end
  end

  it "should be able to Verify password validation for alphanumeric::Tny1853697c" do
    on UsermanagementPage do |action|
      unamearg1 ="Testusr_04"
      pwdarg1   ="Testpwd@01"
      rpwdarg1  ="Testpwd@01"
      expect(action.usernameValid(unamearg1,pwdarg1,rpwdarg1)).to be_true
      unamearg2 ="Testusr_05"
      pwdarg2   ="Test(pwd)0/1"
      rpwdarg2  ="Test(pwd)0/1"
      expect(action.usernameInValid(unamearg2,pwdarg2,rpwdarg2)).to be_true
    end
  end

  it "should be able to Verify password validation must not contains words::Tny1853698c" do
    on UsermanagementPage do |action|
      unamearg1 ="Testusr_06"
      pwdarg1   ="Cisco_01"
      rpwdarg1  ="Cisco_01"
      expect(action.usernameInValid(unamearg1,pwdarg1,rpwdarg1)).to be_true
      unamearg2 ="Testusr_07"
      pwdarg2   ="Testusr_07"
      rpwdarg2  ="Testusr_07"
      expect(action.usernameInValid(unamearg2,pwdarg2,rpwdarg2)).to be_true
    end
  end

  it "should be able to Verify password validation must not contains consecutive characters::Tny1853699c" do
    on UsermanagementPage do |action|
      unamearg ="Testusr_08"
      pwdarg   ="Testttt_01"
      rpwdarg  ="Testttt_01"
      expect(action.usernameInValid(unamearg,pwdarg,rpwdarg)).to be_true
    end
  end

  it "should be able to Verify username tooltip validation::Tny1853694c" do
    on UsermanagementPage do |action|
      #expected=user_management_service['username_tooltip_value']
      expected="User name must be alphanumeric not exceeding 24 characters.\nPermitted special characters are period (.), underscore (_), hyphen (-), and blank space."
      expect(action.uname_tooltip_value).to be == expected
    end
  end

  it "should be able to Verify password tooltip validation::Tny1853695c" do
    on UsermanagementPage do |action|
      #expect=user_management_service['password_tooltip_value']
      expected="Password requirements:\n8 to 24 characters in length.\nAlphanumeric, with one uppercase and one special character. Permitted special characters are !@\#$%^&*_+@.- .\nMust not contain your username or the word'cisco', or their reversed characters.\nMust not repeat three same characters consecutively."
      expect(action.pwd_tooltip_value).to be == expected
    end
  end

  it "should be able to Verify validate roles as mandatory fields::Tny1853700c" do
    on UsermanagementPage do |action|
      expect(action.role_mandatory).to be_true
    end
  end
end

