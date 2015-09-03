require 'spec_helper.rb'

usecase_service = YAML::load(File.open("data/usecase_service.yml"))
interface_serv = usecase_service['common_attribute'][0]
interUtil_serv = usecase_service['interface_Utilization_service'][0]

describe "US11074 Home Menu-InterfaceUtilizationPage" do

  before :all do
    visit InterfaceUtilizationPage
  end

  it "should be able to Verify the Duration Filters in quickview::Tny1641444c" do

    on InterfaceUtilizationPage do |page|
      new_tab = "Interface Utilization"
      page.select_dashboard_tab(new_tab)
      expect_output=interface_serv['all_duration']
      expect(page.interface_duration).to match_array(expect_output)
    end
  end

  it "should be able to Verify the Location in  quickview::Tny1641445c" do

    on InterfaceUtilizationPage do |page|
      page.interface_location
      expect(page).to be_true
    end
  end

  it "should be able to Verify the Interface Group Combination in quickview::Tny1641446c" do

    on InterfaceUtilizationPage do |page|
      page.interface_group
      expect(page).to be_true
    end
  end

  it "should be able apply the filter::Tny1641444c" do

    on InterfaceUtilizationPage do |page|
      page.interface_global_filter
    end
  end

  it "should be able to verify add/remove  individual columns  from settings icon::Tny1641440c" do

    on InterfaceUtilizationPage do |page|
      #          page.table_element.wd.location_once_scrolled_into_view
      sleep 3
      page.interface_setting
      expect(page).to be_true
    end
  end

  it "should be able to verify the Order quickview on interface bars-Table Sorting::Tny1641408c" do

    on InterfaceUtilizationPage do |page|
      sleep 3
      page.interfacetable_sorting
      expect(page).to be_true
    end
  end

  it "should be able to verify backpane in Quickview Pop-up window::Tny1641407c" do

    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['interface_name']
      page.interface_backplane(expect_output)
      expect(page).to be_true
    end
  end

  it "should be verify the interface icons in quickview::Tny1641409c" do

    on InterfaceUtilizationPage do |page|
      page.interface_icons
      expect(page).to be_true
    end
  end

  it "should be verify the interface title in quickview::Tny1641411c" do

    on InterfaceUtilizationPage do |page|
      #      page.errordiscardstitle.should include iterfacetitle
      expect_output=interface_serv['interface_title']
      expect(page.interface_title).to be == expect_output
    end
  end

  it "should be Verify the chart icons in quickview::Tny1641410c " do

    on InterfaceUtilizationPage do |page|

      #       page.errordiscards_quickview_footericons.should include ["Chart Mode", "Grid Mode", "Chart Types", "Export/Print"]
      expect_output=interface_serv['chart_icon']
      expect(page.quickview_footericons).to match_array(expect_output)
    end
  end

  it "should be Verify the Date & Time in quickview::Tny1641412c " do

    on InterfaceUtilizationPage do |page|
      page.quickview_date
      expect=Time.now.strftime("%b %e, %Y")
      expect(page.quickview_date).to be == expect
    end
  end

  it "should be verify tooltip value in chart for particular utilization and speed details::Tny1641415c" do

    on InterfaceUtilizationPage do |page|

      expect(page.interfaceChart_onepointTooltip).not_to be_empty

    end
  end

  it "should be verify tooltip value in chart::Tny1641421c" do

    on InterfaceUtilizationPage do |page|
      expect(page.interfaceChart_allTooltip).not_to be_empty
    end
  end

  it "should be verify the sorting functionality in grid mode::Tny1641417c" do

    on InterfaceUtilizationPage do |page|
      page.interfaceGrid_sorting
      expect(page).to be_true
    end
  end

  it "should be verify the Input Utilization In grid mode::Tny1641419c" do

    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['interface_tableInput']
      expect(page.interfaceGrid_inpututilization).to be == expect_output
    end
  end

  it "should be verify the Output Utilization In grid mode::Tny1641420c" do

    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['interface_tableOutput']
      expect(page.interfaceGrid_oupututilization).to be == expect_output
    end
  end

  it "should be verify the Export/Print button functionality::Tny1641422c" do

    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['report_option']
      expect(page.interface_exportReport_icon).to be == expect_output
    end
  end

  it "should be Verify the File Format Report icon in quickview::Tny1641423c" do

    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['export_formeta']
      expect(page.interface_export_format).to be == expect_output
      #       page.interface_export_format.should include expect_output
    end
  end

  it "should be Verify the Print option in Report icon in quickview::Tny1641424c" do

    on InterfaceUtilizationPage do |page|
      #       expect_output=interface_serv['print_text']
      #       page.interface_report_print.should include expect_output
      page.interface_report_print
    end
  end

  it "should be Verify the Detailed Report features in quickview::Tny1641425c" do

    on InterfaceUtilizationPage do |page|
      page.scheduleReport_feature
      expect(page).to be_true
    end
  end

  it "should be Verify the Detailed Report formet::Tny1641426c" do

    on InterfaceUtilizationPage do |page|

      expect_output=interface_serv['export_formetb']
      expect(page.scheduleReport_format).to be == expect_output
    end
  end

  it "should be verify the schedule report::Tny1641437c" do

    on InterfaceUtilizationPage do |page|
      page.schedule_report
      sleep 2
      page.expect_toaster("Report Schedule updated successfully.")
    end

  end

  it "should be Verify the PIN icon in quickview::Tny1641441c" do

    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['pin_title']
      page.interface_pin.should include expect_output
    end
  end

  it "should be Verify the Close-icon in quickview::Tny1641443c" do

    on InterfaceUtilizationPage do |page|
      page.quickview_closepopup
      expect(page).to be_true
    end
  end

  it "should be Verify the interface details chart icons in quickview ::Tny1641416c" do

    on InterfaceUtilizationPage do |page|

      expect=interUtil_serv['detailview_pagetitle']
      page.interface_detailview.should include expect
    end
  end
end

describe "US10549---InterfaceUtilizationPage" do

  before :all do
    visit InterfaceUtilizationPage
  end

  it "should be Verify the home page::Tny1642650c" do

    on InterfaceUtilizationPage do |page|

      expect_output=interface_serv['home_tab']
      expect(page.home_tabs).to match_array(expect_output)
    end
  end

  it "should be Verify home page default tab selection::Tny1642651c" do

    on InterfaceUtilizationPage do |page|
      page.selected_dashboard_tab.should == "Interface Utilization"
    end
  end

  it "should be Verify interface utilization Tab content(Graph)::Tny1642653c" do

    on InterfaceUtilizationPage do |page|
      page.chart_element.exists?
    end
  end

  it "should be Verify dashlet quick view (Graph))::Tny1642657c" do

    on InterfaceUtilizationPage do |page|
      page.table_element.wd.location_once_scrolled_into_view
      sleep 3
      expect_output=interface_serv['detail_calendar_view']
      expect(page.detail_calender_view).to match_array(expect_output)
    end
  end

  it "should be Verify interface utilization table location::Tny1642660c" do

    on InterfaceUtilizationPage do |page|
      page.interface_table
      page.tablelayout_element.should be_present
    end
  end

  it "should be Verify interface utilization table count and Last updated time::Tny1642661c" do

    on InterfaceUtilizationPage do |page|
      page.totalRecord_element.should be_present
      expect=Time.now.strftime("%b %e, %Y")
      expect(page.interfaceTable_date_noRecords).to be == expect
    end
  end

  it "should be verify show option in the table-Filter::Tny1642662c" do

    on InterfaceUtilizationPage do |page|
      #      expect_output=interface_serv['filter_option']
      #      expect(page.show_option_filter).should == expect_output
      expect(page.show_option_filter).not_to be_empty
    end
  end

  it "should be verify table quick view option::Tny1642666c" do

    on InterfaceUtilizationPage do |page|
      page.quick_element.when_present.click
      page.filterInterfacename_element.should be_present
    end
  end

  it "should be verify export option:Tny1642657c" do

    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['export_formetc']
      expect(page.interfaceTable_export).to match_array(expect_output)
    end
  end

  it "should be verify table record count::Tny1642669c" do

    on InterfaceUtilizationPage do |page|
      actual=page.totalRecord_element.text
      total_count=actual.scan(/\d/).join('').to_i
      expect( page.interfaceTable_rowCount).should == total_count
    end
  end

  it "Should be verify Add new dashboard and few dashlets to it::Tny1841061c" do
    on InterfaceUtilizationPage do |page|
      #      page.filter_element.wd.location_once_scrolled_into_view
      #      page.add_dashlet "Custom Views", "sample_dash1"
      #      page.export_element.wd.location_once_scrolled_into_view
      #      page.export_element.when_present.flash.click
      #      page.dashlets.should == ["Top N Utilized Interfaces","sample_dash1"]
      #
      #      page.filter_element.wd.location_once_scrolled_into_view
      #      new_tab = "Errors and Discards"
      #      page.select_dashboard_tab(new_tab)
      #      page.add_dashlet "Custom Views", "sample_dash1"
      #      page.export_element.wd.location_once_scrolled_into_view
      #      page.export_element.when_present.flash.click
      #      page.dashlets.should == ["sample_dash1"]
      #
      #      page.filter_element.wd.location_once_scrolled_into_view
      #      new_tab = "QoS Classes"
      #      page.select_dashboard_tab(new_tab)
      #      page.add_dashlet "Custom Views", "sample_dash1"
      #      page.export_element.wd.location_once_scrolled_into_view
      #      page.export_element.when_present.flash.click
      #      page.dashlets.should == ["sample_dash1"]
      #
      #      page.filter_element.wd.location_once_scrolled_into_view
      new_tab ="New Dashboard"
      puts "dashboard name: #{new_tab}"
      page.add_dashboard_tab new_tab
      page.selected_dashboard_tab.should be == new_tab
      page.add_dashlet "Custom Views", "sample_dash1"
      page.dashlets.should == ["sample_dash1"]
    end
  end
end

describe "US11075---InterfaceUtilizationPage" do

  before :all do
    visit InterfaceUtilizationPage
  end

  it "should be Verify the filter options::Tny1640782c" do

    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['filter']
      expect(page.interfaceUtilization_Filter).to match_array(expect_output)
    end
  end

  it "should be Verify the Interface Group filter with System Defined (Table)::Tny1640797c/Tny1640798c/Tny1640806c" do

    on InterfaceUtilizationPage do |page|
      page.interface_filterInterfaceGroupTable
      expect(page).to be_true
    end
  end

  it "should be Verify the Interface Group filter with System Defined (Graph)::Tny1640799c/Tny1640800c/Tny1640808c" do

    on InterfaceUtilizationPage do |page|
      page.interface_filterGraph
      expect(page).to be_true
    end
  end

  it "should be Verify the Location filter with SanJose (Table)::Tny1640793c/Tny1640794c/Tny1640802c" do

    on InterfaceUtilizationPage do |page|
      page.interface_filterLocationTable
      expect(page).to be_true
    end
  end

  it "should be Verify the Location filter with SanJose (Graph)::Tny1640795c/Tny1640796c/Tny1640804c" do

    on InterfaceUtilizationPage do |page|
      page.interface_filterGraph
      expect(page).to be_true
    end
  end

  it "should be Verify the Duration filter with Last 7days (Table)::Tny1640789c" do

    on InterfaceUtilizationPage do |page|
      page.interfaceUtilization_7DaysTableData
      expect(page).to be_true
    end
  end

  it "should be Verify the Duration filter with All option (Table)::Tny1640790c" do

    on InterfaceUtilizationPage do |page|
      page.interfaceUtilization_14DaysTableData
      expect(page).to be_true
    end
  end

  it "should be Verify the Duration filter with Last 7days (Graph)::Tny1640791c" do

    on InterfaceUtilizationPage do |page|
      page.interfaceUtilization_7DaysGraphData
      expect(page).to be_true
    end
  end

  it "should be Verify the Duration filter with All option (Graph)::Tny1640792c" do

    on InterfaceUtilizationPage do |page|
      page.interfaceUtilization_14DaysGraphData
      expect(page).to be_true
    end
  end

  it "should be Verify Enter some dumy value in Duration filter field::Tny1836144c" do
    on InterfaceUtilizationPage do |page|
      page.filter_element.wd.location_once_scrolled_into_view
      page.durationFilterBox_element.send_keys "aaa"
      page.durationReset_element.should be_present
    end
  end

  it "should be Verify Quick filter options search::Tny1836143c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceutilization_Quickfilter).to be_true
    end
  end

  it "should be Verify By Timeperiod  filter is similar to Global Filter::Tny1836142c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfacedetailVewTimeperiodFilter_GlobalFilter).to be_true
    end
  end

end

describe "US10551---InterfaceUtilizationPage" do

  before :all do
    visit InterfaceUtilizationPage
  end

  it "should be Verify detailed Analysis Page Launch of the interface chosen and its details ( Date)::Tny1644855c/Tny1644873c" do
    on InterfaceUtilizationPage do |page|
      page.interfaceUtilDetailview_Date
      expect(page).to be_true
    end
  end

  it "should be Verify Detailed Analysis Page Launch of the interface chosen and its details (Date-Hyper link)::Tny1644856c" do
    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['detailView_DatePopUp']
      expect(page.interfaceDetailview_DateHyperLink).should == expect_output
    end
  end

  it "should be Verify Detailed Analysis Page Launch of the interface chosen and Graph Y Axis, calculation mode as Absolute::Tny1644857c" do
    on InterfaceUtilizationPage do |page|
      page.interfaceDetailview_CalculationMode.should include "Rate (Mbps)"
    end
  end

  it "Verify Detailed Analysis page has been Launched and X axis (date) in the Graph has necessary values::Tny1644859c" do
    on InterfaceUtilizationPage do |page|
      page.interfaceDetailview_ChartXaxisDate
      expect(page).to be_true
    end
  end

  it "Verify Detailed Analysis Page Graph Legend::Tny1644860c" do
    on InterfaceUtilizationPage do |page|
      page.interfaceDetailview_GraphLegend
      expect(page).to be_true
    end
  end

  it "Verify Detailed Analysis Page graph Legend - Enable/disable::Tny1644862c" do
    on InterfaceUtilizationPage do |page|
      page.interfaceDetailview_GraphLegendEnableDiable
      expect(page).to be_true
    end
  end

  it "Verify Detailed Analysis Page graph - Mouse Hover::Tny1644863c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceDetailview_GraphValue).not_to be_empty
    end
  end

  it "Verify the paging details are being displayed below the date range Bar::Tny1642743c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceDetailview_PagingDetails).to be_true
    end
  end

  it "Verify the Filters option are getting collapsed and decollapse based on the choice we are selecting::Tny1642745c" do
    on InterfaceUtilizationPage do |page|
      page.interfaceDetailsview_FilterCollapseDecollapse
      expect(page).to be_true
    end
  end

  it "Verify the Duration dropdown list shows the same list as shown in dashboard page::Tny1644866c" do
    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['detailView_duration']
      expect(page.interfaceDetailsview_timePeriod).to match_array(expect_output)
    end
  end

  it "Verify the Devices and Interfaces tabs are showing as Multiple selections when more than 2 items are selected from the dropdown::Tny1644869c" do
    on InterfaceUtilizationPage do |page|
      page.interfaceDetailsview_multipleSelection
      expect(page).to be_true
    end
  end

  it "Verify the Graphs have been generated in the Detailed analysis page based on the filter selection::Tny1644870c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceUtilDetailview_FilterSelectionData).not_to be_empty
    end
  end

  it "Verify the Merged Graph is showing with both the chart and its Value along with Legend::Tny1644872c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceUtilDetailview_MergedData).not_to be_empty
    end
  end

  it "Verify the Detailed analysis page has been added as a favourite in Toogle Navigation::Tny1644864c" do
    on InterfaceUtilizationPage do |page|
      expect=interUtil_serv['detailview_pagetitle']
      page.interfaceUtilDetailview_AddFavourite.should include expect
    end
  end

  it "Verify By Timeperiod  filter is similar to Global Filter::Tny1844038c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfacedetailVewTimeperiodFilter_GlobalFilter).to be_true
    end
  end

  it "Verify Devices and Interface field has the devicename what we have selected in Detailed View Page::Tny1844038c" do
    on InterfaceUtilizationPage do |page|
      expect(page.detailVew_DevicesInterfaces).to be_true
    end
  end

  it "Verify Devices and Interfaces field updated as ALL once we sleceted  Location  as ALL::Tny1844059c" do
    on InterfaceUtilizationPage do |page|
      expect_output=["All","All"]
      expect(page.detailView_DevicesInterfaces_FilterALLOption).to match_array(expect_output)
    end
  end

  it "Verify the Graph generated for the selected interface having IN Errors & Out Errors selected in filter option::Tny1844078c" do
    on InterfaceUtilizationPage do |page|
      expect(page.detailView_Graph_InErrorsOutErrors).not_to be_empty
    end
  end

  it "Verify the RESET button is regaining to the original position for  Devices field after do some changes in that field::Tny1844082c" do
    on InterfaceUtilizationPage do |page|
      expect(page.detailView_ResetDeviceField).to be_true
    end
  end

  it "Verify Reset Button is regaining the default values of the field in detail view calculation mode Graph View::Tny1844085c" do
    on InterfaceUtilizationPage do |page|
      expect(page.detailView_ResetClaculationModeGraphView).to be_true
    end
  end

  it "Verify Scheduled report is working for interface utilization Detail View::Tny1847039c" do
    on InterfaceUtilizationPage do |page|
      page.interface_ScheduleReport
      sleep 2
      page.expect_toaster("Report Schedule updated successfully.")
    end
  end

end

describe "US11901 Home Menu-InterfaceUtilizationPage" do

  before :all do
    visit InterfaceUtilizationPage
  end

  it "Verify the login & Interface Utilization Chart in quick view::Tny1654989c" do
    on InterfaceUtilizationPage do |page|
      page.chart_element.should be_present
      page.filterInterfacename_element.wd.location_once_scrolled_into_view
      page.filterInterfacename_element.should be_present
    end
  end

  it "should be Verify the Trend Line Chart::Tny1654990c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfcaeChart_XandY_AxisLabel).to be_true
    end
  end

  it "should be Verify the Top Utilizations in Chart::Tny1654991c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceTreandLineChart).not_to be_empty
    end
  end

  it "should be Verify Trend Line input-utilization interface name::Tny1654992c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interface_Inputilization).to eq(7)
    end
  end

  it "should be Verify Trend Line output-utilization interface name::Tny1654993c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interface_Outputilization).to eq(7)
    end
  end

  it "should be Verify Interface input-utilization check box in Trend line::Tny1654994c" do
    on InterfaceUtilizationPage do |page|
      page.inpututilization_CheckBox
      expect(page.inputCheckBox_element.checked?).to be_false
      page.inpututilization_CheckBox
      expect(page.inputCheckBox_element.checked?).to be_true
    end
  end

  it "should be Verify Interface output-utilization check box in Trend line::Tny1654996c" do
    on InterfaceUtilizationPage do |page|
      page.outputilization_CheckBox
      expect(page.outputCheckBox_element.checked?).to be_false
      page.outputilization_CheckBox
      expect(page.outputCheckBox_element.checked?).to be_true
    end
  end

  it "should be Verify default All interface I/P & O/P check boxes should be selected in Trend line::Tny1654995c" do
    on InterfaceUtilizationPage do |page|
      expect(page.inputCheckBox_element.checked?).to be_true
      expect(page.outputCheckBox_element.checked?).to be_true
      page.date_element.wd.location_once_scrolled_into_view
      expect(page.allINOPCheckBox_element.checked?).to be_true
    end
  end

  it "should be Verify check input-utilization value in Trend line chart::Tny1654997c" do
    on InterfaceUtilizationPage do |page|
      page.chart_element.wd.location_once_scrolled_into_view
      page.outputilization_CheckBox
      sleep 5
      expect(page.inpututilization_chart).to be_true
    end
  end

  it "should be Verify Un-check input-utilization value in Trend line chart::Tny1654998c" do
    on InterfaceUtilizationPage do |page|
      page.allInputOutputUtilization
      page.chart_element.wd.location_once_scrolled_into_view
      page.inpututilization_CheckBox
      expect(page.inpututilization_chart).to be_true
    end
  end

  it "should be Verify check output-utilization value in Trend line chart::Tny1654999c" do
    on InterfaceUtilizationPage do |page|
      page.allInputOutputUtilization
      page.chart_element.wd.location_once_scrolled_into_view
      page.inpututilization_CheckBox
      sleep 5
      expect(page.outpututilization_chart).to be_true
    end
  end

  it "should be Verify Un-check Output-utilization value in Trend line chart::Tny1655000c" do
    on InterfaceUtilizationPage do |page|
      page.allInputOutputUtilization
      page.chart_element.wd.location_once_scrolled_into_view
      page.outputilization_CheckBox
      expect(page.outpututilization_chart).to be_true
    end
  end

  it "should be Verify  the Dot & its Time name of interface in Graph::Tny1655002c" do
    on InterfaceUtilizationPage do |page|
      expect(page.particularInterfaceName_TrendLineChart).to be_true
    end
  end

  it "should be Verify  the Column settings button ::Tny1655003c" do
    on InterfaceUtilizationPage do |page|
      expect(page.columnSetting).to be_true
    end
  end

  it "should beVerify the Column settings button & Table-Check->% Time Util > 50 ::Tny1655004c" do
    on InterfaceUtilizationPage do |page|
      page.date_element.wd.location_once_scrolled_into_view
      expect(page.interface_settingCehckTimeUtil50).to be_false
    end
  end

  it "should beVerify the Column settings button & Table-Uncheck->% Time Util > 50 ::Tny1655005c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interface_settingCehckTimeUtil50).to be_true
    end
  end

  it "should beVerify the Column settings button & Table-Check->% Time Util > 75 ::Tny1655006c" do
    on InterfaceUtilizationPage do |page|
      page.date_element.wd.location_once_scrolled_into_view
      expect(page.interface_settingCehckTimeUtil75).to be_false
    end
  end

  it "should beVerify the Column settings button & Table-Uncheck->% Time Util > 75 ::Tny1655007c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interface_settingCehckTimeUtil75).to be_true
    end
  end

  it "should beVerify the Column settings button & Table-Check->% Time Util > 90 ::Tny1655008c" do
    on InterfaceUtilizationPage do |page|
      page.date_element.wd.location_once_scrolled_into_view
      expect(page.interface_settingCehckTimeUtil90).to be_false
    end
  end

  it "should beVerify the Column settings button & Table-Uncheck->% Time Util > 90 ::Tny1655009c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interface_settingCehckTimeUtil90).to be_true
    end
  end

  it "should be Verify  the Column settings button ::Tny1655011c" do
    on InterfaceUtilizationPage do |page|
      expect(page.columnSetting).to be_true
    end
  end

end

describe "US10936 Home Menu-InterfaceUtilizationPage" do

  before :all do
    visit InterfaceUtilizationPage
  end

  it "Verify the Filter in Detailed View in quickview::Tny1654926c" do
    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['detailView_filterOption']
      expect(page.interfaceDetailview_FilterOptionsTreanLine).to match_array(expect_output)
    end
  end

  it "Verify the Time Period in Filter page::Tny1654928c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceDetailview_TimePeriodSelection).to eq("13 Months")
    end
  end

  it "Verify the Filter Apply execution in quickview (verify APPLY, APPLY & Close and Reset)::Tny1654927c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceDetailview_FilterResetButton).to be_true
      expect(page.interfaceDetailview_FilterAppltCloseButton).to be_false
      expect(page.interfaceDetailview_ApplyButton).to be_true
    end
  end

  it "Verify the  By Group option in Filter page)::Tny1654930c" do
    on InterfaceUtilizationPage do |page|
      indexA=1
      location="San Jose"
      indexB=0
      page.interfaceDetailview_ByGroup(indexA,location,indexB)
      expect(page.interfaceDetailview_ByGroup(indexA,location,indexB)).to be_true
    end
  end

  it "Verify the Interface Group in Filter page::Tny1654932c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceDetailview_InterfaceGroup).to be_true
    end
  end

  it "Verify the interface option in By Group drop down at Filter page::Tny1654934c" do
    on InterfaceUtilizationPage do |page|
      expect(page.detailview_InterfaceGroupRadioButtonSelection).to be_true
    end
  end

  it "Verify the  device in Filter page::Tny1654935c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceDetailview_Device).to be_true
    end
  end

  it "Verify the Calculation Mode-Absolute in Detail View::Tny1654937c" do
    on InterfaceUtilizationPage do |page|
      page.radio_Absolute_element.flash.click
      expect(page.radio_Absolute_element.checked?).to be_true
    end
  end

  it "Verify the Calculation Mode-Percent in Detail View::Tny1654938c" do
    on InterfaceUtilizationPage do |page|
      page.radio_Percent_element.flash.click
      expect(page.radio_Percent_element.checked?).to be_true
    end
  end

  it "Verify the  interface in Filter page::Tny1654936c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceDetailview_Interface).to be_true
    end
  end

  it "Verify the Calculate By-In Utilization in Detail View::Tny1654939c" do
    on InterfaceUtilizationPage do |page|
      page.filterDiv_element.wd.location_once_scrolled_into_view
      page.checkinUtil_element.flash.click
      page.checkinUtil_element.flash.click
      expect(page.checkinUtil_element.checked?).to be_true
    end
  end

  it "Verify the Calculate By-Out Utilization in Detail View::Tny1654940c" do
    on InterfaceUtilizationPage do |page|
      page.checkoutUtil_element.flash.click
      page.checkoutUtil_element.flash.click
      expect(page.checkoutUtil_element.checked?).to be_true
    end
  end

  it "Verify the Graph View-Merged in Detail View::Tny1654942c" do
    on InterfaceUtilizationPage do |page|
      page.radio_Merged_element.flash.click
      expect(page.radio_Merged_element.checked?).to be_true
    end
  end

  it "Verify the Graph View-Individual in Detail View::Tny1654941c" do
    on InterfaceUtilizationPage do |page|
      page.radio_Individual_element.flash.click
      expect(page.radio_Individual_element.checked?).to be_true
    end
  end

  it "Verify the Linear Regression Trend Selection in Detail View::Tny1654943c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceDetailview_TreandLinear).to be_true
    end
  end

  it "Verify the Graph for Linear Regression in Detail View::Tny1654944c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceDetailview_TreandChart).not_to be_empty
    end
  end

  it "Verify the Graph for Local regression (LOESS) in Detail View::Tny1654948c" do
    on InterfaceUtilizationPage do |page|
      local="Local Regression (LOESS)"
      expect(page.interfaceDetailview_Treand(local)).not_to be_empty
    end
  end

  it "Verify the Graph for Moving Average in Detail View::Tny1654952c" do
    on InterfaceUtilizationPage do |page|
      moving="Moving Average"
      expect(page.interfaceDetailview_Treand(moving)).not_to be_empty
    end
  end

  it "Verify the Graph for ARIMA in Detail View::Tny1654956c" do
    on InterfaceUtilizationPage do |page|
      arima="ARIMA"
      expect(page.interfaceDetailview_Treand(arima)).not_to be_empty
    end
  end

end

describe "US10937 Home Menu-InterfaceUtilizationPage" do

  before :all do
    visit InterfaceUtilizationPage
  end

  it "Verify the Legend box for InPut Linear Regression in Trend Using::Tny1671696c" do
    on InterfaceUtilizationPage do |page|
      page.interfaceDetailviewPage
      linear="Linear Regression"
      expect(page.interfaceDetailview_InputUtilCheckBoxEnableDiableChart(linear)).to be_true
    end
  end

  it "Verify the Legend box for OutPut Linear Regression in Trend Using::Tny1671697c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceDetailview_OutputUtilCheckBoxEnableDiableChart).to be_true
    end
  end

  it "Verify the Leniar Trend Graphs & Values using all Time Duration filter  in Detailed View in quickview::Tny1671698c" do
    on InterfaceUtilizationPage do |page|
      page.filterDiv_element.wd.location_once_scrolled_into_view
      indA=0
      page.interfaceDetailview_AllDuration(indA)
      linear="Linear Regression"
      expect(page.interfaceDetailview_Treand(linear)).not_to be_empty
    end
  end

  it "Verify the Legend box for InPut Local Regression (LOESS) in Trend Using::Tny1671705c" do
    on InterfaceUtilizationPage do |page|
      page.filterDiv_element.wd.location_once_scrolled_into_view
      local="Local Regression (LOESS)"
      expect(page.interfaceDetailview_InputUtilCheckBoxEnableDiableChart(local)).to be_true
    end
  end

  it "Verify the Legend box for OutPut Local Regression (LOESS) in Trend Using::Tny1671706c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceDetailview_OutputUtilCheckBoxEnableDiableChart).to be_true
    end
  end

  it "Verify the Local Regression (LOESS) Graphs & Values using all Time Duration filter  in Detailed View in quickview::Tny1671707c" do
    on InterfaceUtilizationPage do |page|
      page.filterDiv_element.wd.location_once_scrolled_into_view
      indA=1
      page.interfaceDetailview_AllDuration(indA)
      local="Local Regression (LOESS)"
      expect(page.interfaceDetailview_Treand(local)).not_to be_empty
    end
  end

  it "Verify the Legend box for InPut Moving Average in Trend Using::Tny1671714c" do
    on InterfaceUtilizationPage do |page|
      page.filterDiv_element.wd.location_once_scrolled_into_view
      moving="Moving Average"
      expect(page.interfaceDetailview_InputUtilCheckBoxEnableDiableChart(moving)).to be_true
    end
  end

  it "Verify the Legend box for OutPut Moving Average in Trend Using::Tny1671715c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceDetailview_OutputUtilCheckBoxEnableDiableChart).to be_true
    end
  end

  it "Verify the Local Moving Average Graphs & Values using all Time Duration filter  in Detailed View in quickview::Tny1671716c" do
    on InterfaceUtilizationPage do |page|
      page.filterDiv_element.wd.location_once_scrolled_into_view
      indA=2
      page.interfaceDetailview_AllDuration(indA)
      moving="Moving Average"
      expect(page.interfaceDetailview_Treand(moving)).not_to be_empty
    end
  end

  it "Verify the Legend box for InPut ARIMA in Trend Using::Tny1671723c" do
    on InterfaceUtilizationPage do |page|
      page.filterDiv_element.wd.location_once_scrolled_into_view
      arima="ARIMA"
      expect(page.interfaceDetailview_InputUtilCheckBoxEnableDiableChart(arima)).to be_true
    end
  end

  it "Verify the Legend box for OutPut ARIMA in Trend Using::Tny1671724c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceDetailview_OutputUtilCheckBoxEnableDiableChart).to be_true
    end
  end

  it "Verify the  ARIMA Graphs & Values using all Time Duration filter  in Detailed View in quickview::Tny1671725c" do
    on InterfaceUtilizationPage do |page|
      page.filterDiv_element.wd.location_once_scrolled_into_view
      indA=3
      page.interfaceDetailview_AllDuration(indA)
      arima="ARIMA"
      expect(page.interfaceDetailview_Treand(arima)).not_to be_empty
    end
  end

  it "Verify the Legend box for InPut HoltWinters in Trend Using::Tny1671732c" do
    on InterfaceUtilizationPage do |page|
      page.filterDiv_element.wd.location_once_scrolled_into_view
      holt="Holt Winters"
      expect(page.interfaceDetailview_InputUtilCheckBoxEnableDiableChart(holt)).to be_true
    end
  end

  it "Verify the Legend box for OutPut HoltWinters in Trend Using::Tny1671733c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceDetailview_OutputUtilCheckBoxEnableDiableChart).to be_true
    end
  end

  it "Verify the Legend box Graphs & Values using all Time Duration filter  in Detailed View in quickview::Tny1671734c" do
    on InterfaceUtilizationPage do |page|
      page.filterDiv_element.wd.location_once_scrolled_into_view
      indA=4
      page.interfaceDetailview_AllDuration(indA)
      holt="Holt Winters"
      expect(page.interfaceDetailview_Treand(holt)).not_to be_empty
    end
  end

end

describe "US12122- InterfaceUtilizationPage- Calendar View" do

  before :all do
    visit InterfaceUtilizationPage
  end

  it "should be Verify Calender View Detailed Analysis page launching::Tny1719338c" do
    on InterfaceUtilizationPage do |page|
      expect_output = 'Detailed Analysis: Calendar View'
      expect(page.interfaceUtilCalview_launch).to be == expect_output
    end
  end

  it "should be Verify Calender view with Hourly option::Tny1719339c" do
    on InterfaceUtilizationPage do |page|
      page.interfaceUtilCalview_hourlyFilter
      expect_xlabel=["0:00 (Hour)", "1:00", "2:00", "3:00", "4:00", "5:00", "6:00", "7:00", "8:00","9:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00","18:00", "19:00", "20:00", "21:00", "22:00", "23:00"]
      expect(page.interfaceUtilCalview_xlabel).to be == expect_xlabel
      expect_ylabel= 'Hourly Data'
      expect(page.interfaceUtilCalview_ylabel).to be == expect_ylabel
      expect_cellData=["Percentile 95 In Utilization:", "Max In Utilization:", "Avg In Utilization:", "Percentile 95 In Rate:", "Percentile 95 Out Utilization:", "Max Out Utilization:", "Avg Out Utilization:", "Percentile 95 Output Rate:"]
      expect(page.interfaceUtilCalview_cellData).to be == expect_cellData
    end
  end

  it "should be Verify Calender view with Daily option::Tny1719340c" do
    on InterfaceUtilizationPage do |page|
      page.interfaceUtilCalview_dailyFilter
      expect_xlabel=["1 (Day)", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]
      expect(page.interfaceUtilCalview_xlabel).to be == expect_xlabel
      expect_ylabel= 'Daily Data'
      expect(page.interfaceUtilCalview_ylabel).to be == expect_ylabel
      expect_cellData=["Percentile 95 In Utilization:", "Max In Utilization:", "Avg In Utilization:", "Percentile 95 In Rate:", "Percentile 95 Out Utilization:", "Max Out Utilization:", "Avg Out Utilization:", "Percentile 95 Output Rate:"]
      expect(page.interfaceUtilCalview_cellData).to be == expect_cellData
    end
  end

  it "should be Verify Colour code::Tny1719341c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceUtilCalview_cellColor).to be_true
    end
  end

  it "should be Verify the Interface Utilization details by clicking cell::Tny1719342c" do
    on InterfaceUtilizationPage do |page|
      expect_cellData=["Percentile 95 In Utilization:", "Max In Utilization:", "Avg In Utilization:", "Percentile 95 In Rate:", "Percentile 95 Out Utilization:", "Max Out Utilization:", "Avg Out Utilization:", "Percentile 95 Output Rate:"]
      expect(page.interfaceUtilCalview_cellbelowData).to be == expect_cellData
    end
  end

  it "should be Verify the Interface Utilization details in the popup window::Tny1719343c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceUtilCalview_cellTooltip).to be_true
    end
  end

  it "should be Verify Cell colour and status-legend verification::Tny1719344c" do
    on InterfaceUtilizationPage do |page|
      expect_output=["rgb(235, 35, 0)", "Critical", "rgb(255, 115, 0)", "Major", "rgb(255, 204, 0)", "Minor", "rgb(130, 201, 89)", "Normal"]
      expect(page.interfaceUtilCalview_legend).to be == expect_output
    end
  end

  it "should be Verify Cell patterns::Tny1719345c" do
    on InterfaceUtilizationPage do |page|
      expect_output=["M 5.333333333333333 0 L 10.666666666666666 0 L 16 5.333333333333333 L 16 10.666666666666666 L 10.666666666666666 16 L 5.333333333333333 16 L 0 10.666666666666666 0 5.333333333333333 5.333333333333333 0", "rgb(235, 35, 0)", "Critical", "M 0 0 L 16 0 L 8 16 L 0 0", "rgb(255, 115, 0)", "Major", "M 8 0 L 16 16 L 0 16 8 0", "rgb(255, 204, 0)", "Minor", "M 0 0 L 16 0 L 16 16 L 0 16 L 0 0", "rgb(130, 201, 89)", "Normal"]
      expect(page.interfaceUtilCalview_patterns).to be == expect_output
    end
  end

  it "should be Verify help icon::Tny1719346c" do
    on InterfaceUtilizationPage do |page|
      expect_output="Critical: \u2265 90%\nMajor: \u2265 75%\nMinor: \u2265 50%\nNormal: < 50%"
      expect(page.interfaceUtilCalview_helpIcon).to be == expect_output
    end
  end

  it "should be Verify table view::Tny1719347c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceUtilCalview_tableView).to be_true
    end
  end

  it "should be Verify Calender view with filter option by location::Tny1719351c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceUtilCalview_sitefilter).to be_true
    end
  end

  it "should be Verify Calender view with filter option by interface group::Tny1719352c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceUtilCalview_iffilter).to be_true
    end
  end

  it "should be Verify Calender view with filter option by location with single selection::Tny1719353c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceUtilCalview_sitesingle).to be_true
    end
  end

  it "should be Verify Calender view with filter option by location with multiple selection::Tny1719354c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceUtilCalview_sitemultiple).to be_true
    end
  end

  it "should be Verify Calender view with filter option by Interface Group single selection::Tny1719355c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceUtilCalview_ifgrpsingle).to be_true
    end
  end

  it "should be Verify Calender view with filter option by Device with All::Tny1719356c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceUtilCalview_deviceall).to be_true
    end
  end

  it "should be Verify Calender view with filter option by Device with single selection::Tny1719357c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceUtilCalview_devicesingle).to be_true
    end
  end

  it "should be Verify Calender view with filter option by Device with multiple selection::Tny1719358c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceUtilCalview_devicemultiple).to be_true
    end
  end

  it "should be Verify Interface are single picker::Tny1719359c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceUtilCalview_ifsingle).to be_true
    end
  end

  it "should be Verify Calender view with filter option by Interface selection::Tny1719360c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceUtilCalview_ifselect).to be_true
    end
  end

  it "should be Verify Calender view export to CSV option::Tny1719348c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceUtilCalview_ExportCSV).not_to be_empty
    end
  end

end

describe "US18046 - More Usecases Review Comments" do

  before :all do
    visit InterfaceUtilizationPage
  end

  it "should be Verify >50% In and Out  Utilized from Columns list in Interface Utilization table::Tny1816972c" do
    on InterfaceUtilizationPage do |page|
      expect(page.ifutil_columns_50).to be_true
    end
  end

  it "should be Verify >75% In and Out  Utilized from Columns list in Interface Utilization table::Tny1816973c" do
    on InterfaceUtilizationPage do |page|
      expect(page.ifutil_columns_75).to be_true
    end
  end

  it "should be Verify >90% In and Out  Utilized from Columns list in Interface Utilization table::Tny1816974c" do
    on InterfaceUtilizationPage do |page|
      expect(page.ifutil_columns_90).to be_true
    end
  end

  it "should be Verify Order for percentage Utilized (i.e 95,90,75,50) header columns in Interface Utilized table::Tny1816978c" do
    on InterfaceUtilizationPage do |page|
      expect_order=["95% Util In","95% Util Out",">90% Utilized",">75% Utilized",">50% Utilized"]
      expect(page.ifutil_columnorder).to be == expect_order
    end
  end

  it "should be Verify Absolute'  Calculation mode in Interface Detailed view::Tny1816985c" do
    on InterfaceUtilizationPage do |page|
      expect(page.ifdv_absolutemode).to be_true
    end
  end

  it "should be Verify %-Percentage'  Calculation mode in Interface Detailed view::Tny1816986c" do
    on InterfaceUtilizationPage do |page|
      expect(page.ifdv_percentmode).to be_true
    end
  end

  it "should be Verify Graph View options in Detailed Analysis:QOS Classes Page::Tny1816987c" do
    on InterfaceUtilizationPage do |page|
      expect(page.qosdv_graphview).to be_true
    end
  end

  it "should be Verify Graph View with 'Individual' option in Detailed Analysis:QOS Classes Page::Tny1816988c" do
    on InterfaceUtilizationPage do |page|
      expect(page.qosdv_individual).to be_true
    end
  end

  it "should be Verify Graph View with 'Merged' option in Detailed Analysis:QOS Classes Page::Tny1816989c" do
    on InterfaceUtilizationPage do |page|
      expect(page.qosdv_merged).to be_true
    end
  end

  it "should be Verify In Saved Reports table header element changed to 'Name' instaed of 'View Name'::Tny1816991c" do
    on InterfaceUtilizationPage do |page|
      expect(page.savedreport_nametitle).to be_true
    end
  end

  it "should be Verify In columns list changed title from 'MDX Name'  to 'Filter' in Saved Reports Page::Tny1816992c" do
    on InterfaceUtilizationPage do |page|
      expect(page.savedreport_columnfilter).to be_true
    end
  end

end

describe "US19113 - user review comments" do

  before :all do
    visit InterfaceUtilizationPage
  end

  it "should be Verify Quick View Launch from Graph::Tny1854891c" do
    on InterfaceUtilizationPage do |page|
      expect(page.ifutil_topnchartqv_launch).to be_true
    end
  end

  it "should be Verify Quick View Launch from Graph - Grid Mode::Tny1854892c" do
    on InterfaceUtilizationPage do |page|
      expect(page.ifutil_topnchartqv_grid).to be_true
    end
  end

  it "should be Verify sorting happens by time period sequentially in table grid::Tny1854900c" do
    on InterfaceUtilizationPage do |page|
      expect(page.ifutil_topnchartqv_gridsort).to be_true
    end
  end

  it "should be Verify Quick View Launch from Graph - Export CSV::Tny1854894c" do
    on InterfaceUtilizationPage do |page|
      expect(page.ifutil_topnchart_exportcsv).not_to be_empty
    end
  end

  it "should be Verify Quick View Launch from Graph - Scheduled Report::Tny1854896c" do
    on InterfaceUtilizationPage do |page|
      page.ifutil_topnchart_schdrpt
      sleep 2
      page.expect_toaster("Report Schedule updated successfully.")
    end
  end

  it "should be Verify Quick View Launch from Graph - Calendar View::Tny1854897c" do
    on InterfaceUtilizationPage do |page|
      expect_output = 'Detailed Analysis: Calendar View'
      expect(page.ifutil_topnchart_calview).to be == expect_output
    end
  end

  it "should be Verify If-util table tool tip for column detail::Tny1854901c" do
    on InterfaceUtilizationPage do |page|
      expect(page.ifutil_table_title).to be_true
    end
  end

  it "should be Verify Quick View Launch from Graph - Detailed View::Tny1854898c" do
    on InterfaceUtilizationPage do |page|
      expect_output = 'Detailed Analysis: Interface Utilization'
      expect(page.ifutil_topnchart_detailview).to be == expect_output
    end
  end

  it "should be Verify Login page Copy rights Information::Tny1854902c" do
    on InterfaceUtilizationPage do |page|
      expect(page.chk_copyrights).to be_true
    end
  end

end

describe "US19904 - Usecase Review comments" do

  before :all do
    visit InterfaceUtilizationPage
  end

  it "should be Verify report at Schedule Export::Tny1853693c" do
    on InterfaceUtilizationPage do |page|
      expect(page.ifUtilCalview_chkicon).to be_true
    end
  end

  it "should be Verify report at Schedule Export::Tny1853694c" do
    on InterfaceUtilizationPage do |page|
      expect(page.ifUtilCalview_chkmoreact_popup).to be_true
    end
  end

  it "should be Verify Schedule Export::Tny1853695c" do
    on InterfaceUtilizationPage do |page|
      page.ifUtilCalview_schdrpt
      sleep 2
      page.expect_toaster("Report Schedule updated successfully.")
    end
  end

  it "should be Verify Filters at Schedule Export::Tny1880516c" do
    on InterfaceUtilizationPage do |page|
      expect_type=["By Timeperiod", "By Group", "Devices", "Interfaces"]
      expect(page.ifUtilCalview_filtertype).to be == expect_type
    end
  end

  it "should be Verify Filters at Schedule Export::Tny1880517c" do
    on InterfaceUtilizationPage do |page|
      expect(page.ifUtilCalview_sitesearchbox).to be_true
      expect(page.ifUtilCalview_ifgrpsearchbox).to be_true
    end
  end

end

describe "US12106 - IPv6 support in Prime Insight" do

  before :all do
    visit InterfaceUtilizationPage
  end

  it "should be Verify IPv6 support in Interface Utilization::Tny1663120c" do
    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['ipv6device_name']
      expect(page.ipv6_ifutil(expect_output)).to be == expect_output
    end
  end

  it "should be Verify IPv6 devices are available in Interface Utilization Quick View::Tny1663123c" do
    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['ipv6device_name']
      expect(page.ipv6_ifutilQV).to include expect_output
    end
  end

  it "should be Verify IPv6 devices are available in Interface Utilization Detailed View::Tny1663125c" do
    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['ipv6device_name']
      expect(page.ipv6_ifutilDV).to include expect_output
    end
  end

  it "should be Verify IPv6 devices are available in Interface Utilization Calendar View::Tny1663124c" do
    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['ipv6device_name']
      expect(page.ipv6_ifutilCV(expect_output)).to include expect_output
    end
  end

  it "should be Verify IPv6 support in Errors and Discards::Tny1663121c" do
    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['ipv6device_name']
      expect(page.ipv6_errd(expect_output)).to be == expect_output
    end
  end

  it "should be Verify IPv6 support in Errors and Discards Detailed View::Tny1663126c" do
    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['ipv6device_name']
      expect(page.ipv6_errd_DV).to include expect_output
    end
  end

  it "should be Verify IPv6 support in QoS Classes::Tny1663122c" do
    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['ipv6device_name']
      expect(page.ipv6_QoS(expect_output)).to be == expect_output
    end
  end

  it "should be Verify IPv6 support in QoS Classes Quick View::Tny1663127c" do
    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['ipv6device_name']
      expect(page.ipv6_QoS_QV).to include expect_output
    end
  end

  it "should be Verify IPv6 support in QoS Classes Detailed View::Tny1663128c" do
    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['ipv6device_name']
      expect(page.ipv6_QoS_DV).to include expect_output
    end
  end

  it "should be Verify Full length IPv6 support::Tny1663130c" do
    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['ipv6device_name']
      expect(page.ipv6_fulllength(expect_output)).to be == expect_output
    end
  end

  it "should be Verify IPv6 support in saiku query::Tny1663129c" do
    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['ipv6device_ip']
      expect(page.ipv6_saiku).to include expect_output
    end
  end

end