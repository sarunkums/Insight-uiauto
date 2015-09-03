require './spec/spec_helper.rb'

describe "US11481-Log Configuration UI" do

  before :all do
    visit LogConfigurationPage
  end

  it "should be able to Verify naviating to log configuration::Tny1653465c" do
    on LogConfigurationPage do |page|
      page.page_title.should be == "Log Configuration"
    end
  end

  it "should be able to Verify module available for log monitoring::Tny1653466c" do
    on LogConfigurationPage do |page|
      page.module_title.should be == "Reporting and Other Services on Tomcat"
    end
  end

  it "should be able to Verify default log level::Tny1653468c" do
    on LogConfigurationPage do |page|
      expect_output='Warning'
      page.default_loglevel.should be == "Warning"
    end
  end

  it "should be able to Verify log levels::Tny1653467c" do
    on LogConfigurationPage do |page|
      expect_output=['Debug','Error','Fatal','Information','Warning']
      expect(page.log_levels).to be == expect_output
    end
  end

  it "should be able to Verify Edit log level::Tny1653469c" do
    on LogConfigurationPage do |page|
      expect(page.edit_loglevel).to be_true
    end
  end

  it "should be able to Verify save-log level::Tny1653470c" do
    on LogConfigurationPage do |page|
      expect_output='Information'
      expect(page.save_loglevel).to be == expect_output
    end
  end

  it "should be able to Verify cancel-log level::Tny1653471c" do
    on LogConfigurationPage do |page|
      expect_output='Information'
      expect(page.cancel_loglevel).to be == expect_output
    end
  end

  it "should be able to Verify reset to default::Tny1653473c" do
    on LogConfigurationPage do |page|
      expect_output='Warning'
      expect(page.reset_loglevel).to be == expect_output
    end
  end

end