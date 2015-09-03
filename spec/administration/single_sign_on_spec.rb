require 'spec_helper.rb'

base_service = YAML::load(File.open("data/base_service.yml"))
qos_serv = base_service['single_sign_on_service'][0]

describe "US11373-SingleSignOn" do

  before :all do
    visit SingleSignOn
  end

  it"Should be Single Sign On button in Administration::Tny1695259c" do

    on SingleSignOn do  |page|
      page.ssoContent_element.flash
      page.ssoContent_element.should be_present
    end
  end

  it "Should be verify Selecting the Favorite for Single Sign-On page::Tny1695261c" do
    on SingleSignOn do |page|
      expect_output=qos_serv['qos_pagetitle']
      expect(page.singleSignOn_AddFavourite).to include(expect_output)
      sleep 3
      page.favouriteTitles_element.click
      page.ssoContent_element.should be_present
    end
  end

  it "Should be verify UnSelect the Favorite for Single Sign-On page::Tny1695262c" do
    on SingleSignOn do |page|
      expect_output=qos_serv['qos_pagetitle']
      expect(page.singleSignOn_RemoveFavourite).not_to include(expect_output)
    end
  end

  it "Should be verify Checked Enable SSO check Box::Tny1695263c" do
    on SingleSignOn do |page|
      sleep 3
      page.toggleIcon_element.flash.click
      sleep 5
      page.ssoCheckBox_element.click
      sleep 2
      page.serverIPDisable_element.should_not be_present
      page.portDisable_element.should_not be_present
    end
  end

  it "Should be verify Unchecked Enable SSO check Box::Tny1695264c" do
    on SingleSignOn do |page|
      page.ssoCheckBox_element.click
      sleep 2
      page.serverIPDisable_element.should be_present
      page.portDisable_element.should be_present
    end
  end

  it "Should be verify Port No support for Single Sign-On configuration::Tny1695265c" do
    on SingleSignOn do |page|
      page.ssoCheckBox_element.click
      sleep 2
      page.serverIPEnable_element.set"192.168.115.240"
      page.portEnable_element.set"443"
      page.testConnection_element.flash.click
      page.expect_toaster("Connection to SSO server 192.168.115.240 is successful")
    end
  end

  it "Should be verify Clicking on Clear button in Single Sign-On page::Tny1695266c" do
    on SingleSignOn do |page|
      page.ssoClear_element.click
      sleep 2
      page.serverIPDisable_element.should be_present
      page.portDisable_element.should be_present
    end
  end

  it "Should be verify Checking Test Connection with Invalid values in Single Sign-On(SSO) page::Tny1695268c" do
    on SingleSignOn do |page|
      page.ssoCheckBox_element.click
      sleep 2
      page.serverIPEnable_element.set"192.118.105.240"
      page.portEnable_element.set"444"
      page.testConnection_element.flash.click
      sleep 3
      page.expect_toaster("Error while connecting to SSO Server")
    end
  end

  it "Should be verify Restart Pop Up window in SSO page::Tny1695270c" do
    on SingleSignOn do |page|
      page.serverIPEnable_element.clear
      page.serverIPEnable_element.set"192.168.115.240"
      page.portEnable_element.clear
      page.portEnable_element.set"443"
      page.testConnection_element.flash.click
      page.expect_toaster("Connection to SSO server 192.168.115.240 is successful")
      sleep 2
      page.ssoApply_element.click
      page.alert_element.flash
      page.alert_element.should be_present
      page.deletealertCancel_element.flash.click

    end
  end

  it "Should be verify 'Clear' button should be grayed out by default in Single Sign-On Page::Tny1844506c" do
    on SingleSignOn do |page|
      page.ssoCheckBox_element.click
      page.ssoClearDisable_element.should be_present
    end
  end

  it "Should be verify Favorite icon tool tip is inconsistent behaviour in IE10 browser::Tny1844507c" do
    on SingleSignOn do |page|
      page.favouriteIcon_element.title.should eq("Favorite")
    end
  end

  it "should be able to Verify Hyphen'-' symbol  is missed in 'Single Sign On' sentence in SSO page::Tny1844508c" do
    on SingleSignOn do |page|
      actual="Single Sign-On"
      expect(page.pageTitle_element.text).to eql(actual)
    end
  end

end
