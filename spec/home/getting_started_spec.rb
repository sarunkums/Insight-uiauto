require 'spec_helper.rb'

describe "US6419-Getting Started PopUp" do

  before :all do
    on GettingStarted do |page|
      page.globaladmin_element.flash.click
      page.gettingstart_element.flash.click
    end
  end

  it "should be verify Getting Started Pop up::Tny1662725c" do
    on GettingStarted do |page|
      sleep 3
      page.wizardContent_element.flash
      page.wizardContent_element.should be_present
    end
  end

  it "should be Verify Getting Started Pop Up window options::Tny1662726c" do
    on GettingStarted do |page|
      expect(page.gettingStartedPopUP_Options).to be_true
      page.donotShow_element.flash.should be_present
      sleep 3
      page.close_element.flash.should be_present
    end
  end

  it "should be Verify Close button in Getting Started pop up window::Tny1662727c" do
    on GettingStarted do |page|
      page.close_element.when_present.flash.click
      sleep 3
      page.close_element.should_not be_present
    end
  end

  it "should be Verify Don not show this on start up check box::Tny1662728c" do
    on GettingStarted do |page|
      expect(page.gettingStartedPopUP_checkBoxUnchecked).to be_false
    end
  end

  it "should be Verify clicking on Do not show this on start up check box in Getting started pop Up window::Tny1662729c" do
    on GettingStarted do |page|
      expect(page.gettingStartedPopUP_checkBoxChecked).to be_true
    end
  end

  it "should be Verify Getting started option in setting button drop down list from the top right side of the page::Tny1662731c" do
    on GettingStarted do |page|
      page.checkBox_element.click
      sleep 3
      page.close_element.flash.click
      page.globaladmin_element.flash.click
      page.gettingstart_element.flash.should be_present
    end
  end

  it "should be Verify Click on Getting started option in setting button drop down list from the top right side of the page.::Tny1662732c" do
    on GettingStarted do |page|
      page.gettingstart_element.flash.click
      page.wizardContent_element.should be_present
    end
  end

  it "should be Verify Manage Users and Roles option from the Getting started pop up window.::Tny1662734c" do
    on GettingStarted do |page|
      page.userManamgement_element.flash.click
      sleep 3
      page.pageTitle_element.flash
      expect_output="User Management"
      expect(page.pageTitle_element.text).to be == expect_output
    end
  end

  it "should be Verify Data Sources option from the Getting started pop up window::Tny1662735c" do
    on GettingStarted do |page|
      page.globaladmin_element.flash.click
      page.gettingstart_element.flash.click
      page.dataSources_element.flash.click
      sleep 3
      page.pageTitle_element.flash
      expect_output="Data Sources"
      expect(page.pageTitle_element.text).to be == expect_output
    end
  end

  it "should be Verify Custom Views option from the Getting started pop up window::Tny1662736c" do
    on GettingStarted do |page|
      page.globaladmin_element.flash.click
      page.gettingstart_element.flash.click
      page.customViews_element.flash.click
      sleep 3
      page.pageTitle_element.flash
      expect_output="Custom Views"
      expect(page.pageTitle_element.text).to be == expect_output
    end
  end

  it "should be Verify Saved Reports option from the Getting started pop up window::Tny1662737c" do
    on GettingStarted do |page|
      page.globaladmin_element.flash.click
      page.gettingstart_element.flash.click
      page.savedReports_element.flash.click
      sleep 3
      page.pageTitle_element.flash
      expect_output="Saved Reports"
      expect(page.pageTitle_element.text).to be == expect_output
    end
  end

  it "should be Verify do not show this on start up check box in Getting started pop Up window and logout operation::Tny1662730c" do
    on GettingStarted do |page|
      page.globaladmin_element.flash.click
      page.gettingstart_element.flash.click
      page.checkBox_element.click
    end
    on LoginPage do |page|
      page.logoutFromPC
      page.login_with @pc_server['app_username'], @pc_server['app_password']
      sleep 10
    end
    on GettingStarted do |page|
      page.evaluation_alert
      page.wizardContent_element.should_not be_present
    end
  end

end