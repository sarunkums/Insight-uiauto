require 'spec_helper'

describe "US11461-CustomViews" do

  before :all do
    visit CustomViewsPage
  end

  it "should be able to verify tool tip and labels::Tny1842978c" do    ##Regression TestCase
    on SaikuPopupPage do |page|
      page.saiku_tooltip
      expect_output= ['Open query','Run query','Automatic execution','Toggle fields','Toggle sidebar','Hide Parents','Non-empty','Swap axis','Show MDX','Toggle Chart Preview']
      expect(page.saiku_tooltip).to be == expect_output
    end
  end

  it "should be able to verify chart preview ::Tny1842979c" do   ##Regression TestCase
    on SaikuPopupPage do |page|
      page.saiku_cube_selection
      page.saiku_row_column_selection
      expect_output= ['Column Chart','Line Chart','Scatter Chart']
      expect(page.saiku_chart_type_preview).to be == expect_output
    end
  end

  it "should be able to verify chart preview - export and schedule report option ::Tny1842981c" do   ##Regression TestCase
    on SaikuPopupPage do |page|
      #      expect(page.saiku_chart_export).to be_true
      page.saiku_chart_export
      #      sleep 2
      puts"going to toster"
      page.expect_toaster("Report Schedule updated successfully.")
      page.saiku_SchuduleReportClose
    end

  end

  it "should be able to open saiku page::Tny1636059c" do

    on CustomViewsPage do |page|
      page.addsaiku_element.flash.click
    end
    sleep 8
    on SaikuPopupPage do |page|
      expect(page.saiku_popup).to be_true
    end
  end

  it "should be able to verify cube selection::Tny1636060c" do  ##Regression case Modified
    on SaikuPopupPage do |page|
      expect(page.saiku_cube_selection).to be_true
    end
  end

  it "should be able to verify row & column selection and save query ::Tny1636061c" do
    on SaikuPopupPage do |page|
      expect(page.saiku_row_column_selection).to be_true
      page.saiku_save_query
    end
  end

  it "should be able to verify custom view page - quick view::Tny1842980c" do   ##Regression TestCase

    on CustomViewsPage do |page|
      expect(page.customview_quickview).not_to be_empty
    end
  end

  it "should be able to verify custom view page query display::Tny1636062c" do
    on CustomViewsPage do |page|
      expect(page.saiku_open_query).to be_true
    end
  end

  it "should be able to verify custom view settings::Tny1636065c" do
    on CustomViewsPage do |page|
      expect(page.customview_setting).to be_true
    end
  end

  it "should be able to verify quick filter::Tny1636066c" do
    on CustomViewsPage do |page|
      expect(page.customview_filter).to be_true
    end
  end

  it "should be able to verify custom view record count::Tny1636067c" do
    on CustomViewsPage do |page|
      expect(page.customview_recordcount).to be_true
    end
  end

  it "should be able to  verify open query::Tny1636069c" do
    on CustomViewsPage do |page|
      page.addsaiku_element.click
      sleep 3
    end
    on SaikuPopupPage do |page|
      expect(page.open_query).to be_true
    end
  end

  it "should be able to verify repository search option::Tny1636087c" do
    on SaikuPopupPage do |page|
      expect(page.repository_search).to be_true
    end

  end

  #  it "should be able to verify repository delete query::Tny1636088c" do
  #
  #    content = on_page(SaikuPopupPage).repository_delete_query
  #    content.should be_true
  #
  #  end

  it "should be able to verify repository folder creation::Tny1636088c" do
    on SaikuPopupPage do |page|
      expect(page.repository_folder_creation).to be_true
    end
  end

  #  it "should be able to verify set permission for query in repository::Tny1636091c" do
  #    content = on_page(SaikuPopupPage).repository_permisson_query
  #    content.should be_true
  #  end

  it "should be able to verify save option in repository::Tny1636092c" do
    on SaikuPopupPage do |page|
      expect(page.repository_save).to be_true
    end
  end

  it "should be able to verify toggle side bar::Tny1636070c" do
    on SaikuPopupPage do |page|
      expect(page.saiku_toggle_sidebar).to be_true
    end
  end

  it "should be able to verify toggle field::Tny1636071c" do
    on SaikuPopupPage do |page|
      expect(page.saiku_toggle_field).to be_true
    end
  end

  it "should be able to verify swap axis::Tny1636073c" do
    on SaikuPopupPage do |page|
      expect(page.saiku_swap_axis).to be_true
    end
  end

  it "should be able to verify MDX::Tny1636075c" do
    on SaikuPopupPage do |page|
      expect(page.saiku_show_MDX).not_to be_empty
    end
  end

  it "should be able to verify chart preview::Tny1636077c" do
    on SaikuPopupPage do |page|
      expect(page.saiku_chart_preview).to be_true
    end
  end

  #  it "should be able to verify tag::Tny1636078c" do
  #    content = on_page(SaikuPopupPage).saiku_tag
  #    content.should be_true
  #  end

  it "should be able to verify save query to a folder::Tny1636089c" do
    on SaikuPopupPage do |page|
      expect(page.saikuQuery_insideFolder).to be_true
    end
  end

  it "should be able to verify custom view page query deletion::Tny1636063c" do
    on SaikuPopupPage do |page|
      expect(page.saiku_delete_query).to be_true
    end
    #    on_page(CustomViewsPage).expect_toaster "Custom view is successfully deleted"
  end

end

describe "US11462-CustomViews" do

  before :all do
    visit CustomViewsPage
  end

  it "Should be verify Launching Quick view from Custom view page::Tny1653180c" do
    on CustomViewsPage do |page|
      page.viewname_element.when_present.clear
      page.discription_element.when_present.clear
      page.customViewrow1QuickView_element.flash.click
      page.dijitPopup_element.should be_present
    end
  end

  it "Should be Verify the tool tips are available in quick view::Tny1653181c" do
    on CustomViewsPage do |page|
      page.chartMode_element.hover
      expect(page.chartMode_element.title).to eq("Chart Mode")
      page.gridMode_element.hover
      expect(page.gridMode_element.title).to eq("Grid Mode")
      page.chartTypes_element.hover
      expect(page.chartTypes_element.title).to eq("Chart Types")
      page.quickViewClose_element.hover
      expect(page.quickViewClose_element.title).to eq("Close")
    end
  end

  it "Should be Verify chart mode in quick view::Tny1653182c" do
    on CustomViewsPage do |page|
      page.gridMode_element.flash.click
      page.chartMode_element.flash.click
      page.chartNode_element.should be_present
    end
  end

  it "Should be Verify grid mode in quick view::Tny1653183c" do
    on CustomViewsPage do |page|
      page.gridMode_element.flash.click
      page.gridNode_element.should be_present
    end
  end

  it "Should be verify scheduled reports in quick view::Tny1653185c" do
    on CustomViewsPage do |page|
      page.customQuickView_scheduleReport
      sleep 2
      page.expect_toaster("Report Schedule updated successfully.")
    end
  end

  it "should be Verify the custom quickView Export to CSV::Tny1653186c" do

    on CustomViewsPage do |page|
      expect(page.customQuickView_ExportCSVFormet).not_to be_empty
    end
  end

  it "should be Verify the Date & Time in quickview::Tny1641287c " do

    on CustomViewsPage do |page|
      expect=Time.now.strftime("%b %e, %Y")
      expect(page.customquickview_date).to be == expect
    end
  end

end