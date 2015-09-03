require 'spec_helper.rb'

describe "Home Menu" do

  before :all do
#    visit CustomViewsPage
#    on CustomViewsPage do |page|
#      page.homeDashlet_Data
#    end
    visit HomePage
  end

  it "should be able to verify dashlet search option::Tny1635830c" do
    on HomePage do |page|
      dash_search="sample_dash1"
      new_tab = "Search Dashlet"
      page.add_dashboard_tab new_tab
      page.dashlet_search dash_search
      page.add_dashlet "Custom Views", "sample_dash1"
      page.dashlets.should include "sample_dash1"
    end
  end

  it "should be able to verify  dashlet mode::Tny1635835c" do
    content = on_page(HomePage).dashlet_mode
    content.should be_true
  end

  it "should be able to verify  grid mode::Tny1635837c" do
    content = on_page(HomePage).grid_mode
    content.should be_true
  end

  it "should be able to verify  values in x axis and y axis::Tny1635840c" do
    content = on_page(HomePage).homechart_tooltip_value
    content.should be_true
  end

  it "should able to verify graph model available in dashlet::Tny1635836c"  do
    content = on_page(HomePage).chart_types
    content.should be_true
  end

  it "should be able to verify time stamp for dashlet::Tny1635839c" do
    content = on_page(HomePage).dashlet_bottom_timestamp
    content.should be_true
  end

  it "should be able to Add Dashboard::Tny1635825c" do
    on HomePage do |page|
      new_tab ="New Dashboard"
      puts "dashboard name: #{new_tab}"
      page.add_dashboard_tab new_tab
      page.selected_dashboard_tab.should be == new_tab
    end
  end

  it "should be able to Rename Dashboard::Tny1635826c" do
    on HomePage do |page|
      update_tab="Update Dashboard"
      page.rename_dashboard_as update_tab
      page.dashboard_tab_element.text.should include update_tab # check for screenshot
    end
  end

  it "should be able to add dashlets::Tny1635827c" do
    on HomePage do |page|
      new_tab = "Add Dashlet"
      page.add_dashboard_tab new_tab
      page.add_dashlet "Custom Views", "sample_dash1"
      page.add_dashlet "Custom Views", "sample_dash2"
      page.add_dashlet "Custom Views", "sample_dash3"
      page.dashlets.should == ["sample_dash1", "sample_dash3", "sample_dash2"]
    end
  end

  it "should be able to delete dashlets::Tny1635829c" do
    on HomePage do |page|
      page.selected_dashboard_tab.should be == "Add Dashlet"
      page.close_dashlet page.dashlet("sample_dash1")
      page.expect_alert "Are you sure you want to delete this dashlet?"
      page.alert_ok
      page.dashlets.should_not include "sample_dash1"
    end

  end

  it "should set different layouts to the dashboard::Tny1635832c" do
    on HomePage do |page|
      new_tab="Dashlets Layout"
      page.add_dashboard_tab new_tab
      page.add_dashlet "Custom Views", "sample_dash1"
      page.add_dashlet "Custom Views", "sample_dash2"
      page.add_dashlet "Custom Views", "sample_dash3"

      expected_dashlets = {
        "100"   => ["sample_dash1", "sample_dash2", "sample_dash3"],
        "50/50" => ["sample_dash1", "sample_dash3", "sample_dash2"],
        "3 col" =>  ["sample_dash1", "sample_dash2", "sample_dash3"],
        "4 col" =>  ["sample_dash1", "sample_dash2", "sample_dash3"]
      }
      ["100", "50/50", "3 col", "4 col"].each do |layout|
        page.set_dashboard_layout_as layout
        page.dashlets.should == expected_dashlets[layout]
      end
    end
  end

  it "should add the filters::Tny1635831c" do
    on HomePage do |page|

      new_tab = "Filter Dashlets"
      page.add_dashboard_tab new_tab
      page.add_dashlet "Custom Views", "sample_dash1"
      page.add_dashlet "Custom Views", "sample_dash2"
      page.add_dashlet "Custom Views", "sample_dash3"

      page.add_filter "Duration"
      page.add_filter "Location"
      page.add_filter "Interface Group"
      page.add_filter "QoS Classmap"
      page.global_filters.should include "Duration", "Location\nAll", "Interface Group\nAll","QoS Classmap"

    end
  end

  it "should be able to manage dashboard::Tny1635833c" do
    on HomePage do |page|
      page.add_dashboard_tab "ManageTab"
      page.add_dashlet "Custom Views", "sample_dash1"
      page.add_dashlet "Custom Views", "sample_dash2"
      page.add_dashlet "Custom Views", "sample_dash3"
      page.mark_as_default_dashboard
    end
    visit CustomViewsPage
    visit(HomePage).selected_dashboard_tab.should == "ManageTab"
  end

  it "should be able to Reset Dashboard::Tny1635834c" do
    on HomePage do |page|
      new_tab = "Reset Dashboard"
      page.add_dashboard_tab new_tab
      page.reset_dashboard
      page.expect_alert "This action will delete every customization you made in any tab. It will also delete all custom tabs you have added. Are you sure you want to reset dashboard settings?"
      page.alert_ok
    end
    on HomePage do |page|
      page.dashboard_tab_element.text.should_not include "Reset Dashboard"
    end
  end

  #
  #    it "should able to verify export option PDF & CSV file::Tny1635838c"  do
  #      on HomePage do |page|
  #        new_tab = "Export Dashlet"
  #        page.add_dashboard_tab new_tab
  #        page.add_dashlet "Custom Views", "sample_dash1"
  #        page.export_dashboard :as=>:pdf
  #        sleep 2
  #        toaster = page.expect_toaster(/export started.*is complete./m, 20)
  #        sleep 5
  #        page.export_dashboard :as=>:csv
  #        sleep 2
  #        toaster = page.expect_toaster(/export started.*is complete./m, 20)
  #        sleep 3
  #
  #      end
  #    end
  #
  #    it "should be able to close custom dashboard::Tny1635842c" do
  #      on HomePage do |page|
  #        page.close_dashboard_tab "Export Dashlet"
  #        page.expect_alert "Are you sure you want to delete this tab?"
  #        page.alert_ok
  #        page.dashboard_tab_element.text.should_not include "Export Dashlet"
  #      end
  #    end

end