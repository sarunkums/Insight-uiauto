require 'spec_helper.rb'

describe "US12971-Data Sources" do

  before :all do
    visit DataSourcesPage
  end

  it "should be Verify the Data Source in System Setup column::Tny1662788c" do
    on DataSourcesPage do |page|
      expect_output="Data Sources"
      expect(page.pageTitle_element.text).to be == expect_output
      expect(page.dataSourceIPDetails).not_to be_empty
    end
  end

  it "should be Verify the Administration column and System Setup column::Tny1662787c" do
    on DataSourcesPage do |page|
      page.toggleIcon_element.when_present.flash.click
      page.administradion_element.when_present.flash.click
      expect_output=["User Management","License Management","Smart License","Single Sign-On","System Setup","Backup","Data Sources","Email Settings","Log Configuration"]
      expect(page.slideMenuPages).to be == expect_output
    end
  end

  it "should be Verify the pop window/Column Name in Data Source::Tny1662789c" do
    on DataSourcesPage do |page|
      page.dataSource_element.flash.click
      expect(page.dataSourceColumnDetails).to include("IP Address","Application Name","Application Version","Last Access Time")
    end
  end

  it "should be Verify the Coloumn settings ( * ) icon in pop window in Data Source::Tny1662792c" do
    on DataSourcesPage do |page|
      datasourceTable=page.datasourceTable_element
      datasourceTableToolbar=page.datasourceTableToolbar_element
      page.headers_of(datasourceTable).should include "IP Address", "Application Name", "Application Version", "Last Access Time"
      page.toggle_visibility_for_column(datasourceTableToolbar, "IP Address IP Address")
      page.toggle_visibility_for_column(datasourceTableToolbar, "IP Address IP Address")

    end
  end

  it "should be Verify the  buttons in Column settings::Tny1662793c" do
    on DataSourcesPage do |page|
      datasourceTable=page.datasourceTable_element
      datasourceTableToolbar=page.datasourceTableToolbar_element
      page.headers_of(datasourceTable).should include "IP Address", "Application Name", "Application Version", "Last Access Time"
      page.toggle_visibility_for_column(datasourceTableToolbar, "IP Address IP Address")
      page.headers_of(datasourceTable).should include "Application Name", "Application Version", "Last Access Time"
    end
  end

  it "Should be Verify the IP check box in pop window::Tny1662795c" do
    on DataSourcesPage do |page|
      page.firstRadio_element.click
      expect(page.firstRadio_element.checked?).to be_true
      page.firstRadio_element.click
      expect(page.firstRadio_element.checked?).to be_false
    end
  end

  it "Should be Verify the Delete of IP in check box in pop window::Tny1662796c" do
    on DataSourcesPage do |page|
      datasourceTableToolbar=page.datasourceTableToolbar_element
      page.toggle_visibility_for_column(datasourceTableToolbar, "IP Address IP Address")
      firstRowCell1=page.firstRowCell1_element.text
      page.firstRadio_element.click
      page.deleteDataSource_element.flash.click
      page.deletealertOK_element.flash.click
      expect(page.dataSourceIPDetails).not_to include(firstRowCell1)
    end
  end

  it "Should be Verify the Selected 1 before to Coloumn settings ( * ) icon in pop window in Data Source::Tny1662798c" do
    on DataSourcesPage do |page|
      page.firstRadio_element.click
      actual_output=page.rowSelection_element.flash.text
      puts "Actual Row Count: #{actual_output}"
      page.firstRadio_element.click
      sleep 3
      expect(page.rowSelection_element.flash.text).not_to eq(actual_output)
    end
  end

end
