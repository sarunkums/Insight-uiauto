require './spec/spec_helper.rb'

usecase_service = YAML::load(File.open("data/usecase_service.yml"))
interface_serv = usecase_service['common_attribute'][0]
errors_serv = usecase_service['errors_and_discards_service'][0]

describe "US10550-Home Menu-Errors & Discards" do

  before :all do
    visit ErrorsandDiscardsPage
  end

  it "should be able to Verify the Duration Filters in quickview::Tny1641318c" do

    on ErrorsandDiscardsPage do |page|
      new_tab = "Errors and Discards"
      page.select_dashboard_tab(new_tab)
      expect_output=interface_serv['all_duration']
      expect(page.errordiscard_tab).to match_array(expect_output)
    end
  end

  it "should be able to Verify the Location Filters in quickview::Tny1641319c" do

    on ErrorsandDiscardsPage do |page|
      page.errordiscards_location
      expect(page).to be_true
    end
  end
  it "should be able to Verify the Interface Group Combination in quickview::Tny1641320c" do

    on ErrorsandDiscardsPage do |page|
      page.errordiscards_group
      expect(page).to be_true
    end
  end

  it "should be able apply the filter::Tny1641319c" do

    on ErrorsandDiscardsPage do |page|
      page.errordiscard_global_filter
    end

  end

  it "should be able to verify add/remove  individual columns  from settings icon::Tny1641314c" do
    on ErrorsandDiscardsPage do |page|
      page.errors_and_discards_setting
      expect(page).to be_true
    end
  end

  it "should be able to verify the Order quickview on Errors & Discards bars-Table Sorting::Tny1641282c" do

    on ErrorsandDiscardsPage do |page|
      page.interfacetable_sorting
      expect(page).to be_true
    end
  end
  it "should be able to verify the Order quickview on Errors & Discards bars-Table Sorting::Tny1836090c" do   ##Regression Testcase
    on ErrorsandDiscardsPage do |page|
      page.interfacetable_sorting
      expect(page).to be_true
    end
  end

  it "should be able to verify backpane in Quickview Pop-up window::Tny1641281c" do

    on ErrorsandDiscardsPage do |page|
      expect_output=interface_serv['interface_name']
      page.interface_backplane(expect_output)
      expect(page).to be_true
    end
  end

  it "should be verify the interface icons in quickview::Tny1641283c" do

    on ErrorsandDiscardsPage do |page|
      page.interface_icons
      expect(page).to be_true
    end
  end

  it "should be verify the interface title in quickview::Tny1641285c" do

    on ErrorsandDiscardsPage do |page|
      #      page.errordiscardstitle.should include iterfacetitle
      expect_output=interface_serv['interface_title']
      expect(page.interface_title).to be == expect_output
    end
  end

  it "should be Verify the chart icons in quickview::Tny1641284c " do

    on ErrorsandDiscardsPage do |page|

      #       page.errordiscards_quickview_footericons.should include ["Chart Mode", "Grid Mode", "Chart Types", "Export/Print"]
      expect_output=interface_serv['chart_icon']
      expect(page.quickview_footericons).to match_array(expect_output)
    end
  end

  it "should be Verify the Date & Time in quickview::Tny1641286c " do

    on ErrorsandDiscardsPage do |page|
      expect=Time.now.strftime("%b%e, %Y")
      expect(page.quickview_date).to be == expect
    end
  end

  it "should be verify tooltip value in chart for particular utilization and speed details::Tny1641289c" do

    on ErrorsandDiscardsPage do |page|

      expect(page.interfaceChart_onepointTooltip).not_to be_empty

    end
  end

  it "should be verify tooltip value in Interface quick view chart for particular utilization ::Tny1836088c" do  ## Regression Testcase

    on ErrorsandDiscardsPage do |page|

      expect(page.interfaceChart_onepointTooltip).not_to be_empty

    end
  end

  it "should be verify tooltip value in chart::Tny1641295c" do

    on ErrorsandDiscardsPage do |page|
      expect(page.interfaceChart_allTooltip).not_to be_empty
    end

  end

  it "should be verify the grid mode displays information in column wise ::Tny1836091c" do    ##Regression Testcase

    on ErrorsandDiscardsPage do |page|
      expect_output=['Time Period','Input Utilization (%)','Output Utilization (%)']
      expect(page.interface_Gridmode).to be == expect_output
    end
  end

  it "should be verify the sorting functionality in grid mode::Tny1641291c" do

    on ErrorsandDiscardsPage do |page|
      page.interfaceGrid_sorting
      expect(page).to be_true
    end
  end

  it "should be verify the Input Utilization In grid mode::Tny1641293c" do

    on ErrorsandDiscardsPage do |page|
      expect_output=interface_serv['interface_tableInput']
      expect(page.interfaceGrid_inpututilization).to be == expect_output
    end
  end

  it "should be verify the Output Utilization In grid mode::Tny1641294c" do

    on ErrorsandDiscardsPage do |page|
      expect_output=interface_serv['interface_tableOutput']
      expect(page.interfaceGrid_oupututilization).to be == expect_output
    end
  end

  it "should be verify the Input Utilization In grid mode::Tny1836092c" do  ##Regression Testcase

    on ErrorsandDiscardsPage do |page|
      expect_output=interface_serv['interface_tableInput']
      expect(page.interfaceGrid_inpututilization).to be == expect_output
    end
  end

  it "should be verify the Output Utilization In grid mode::Tny1836093c" do   ##Regression Testcase

    on ErrorsandDiscardsPage do |page|
      expect_output=interface_serv['interface_tableOutput']
      expect(page.interfaceGrid_oupututilization).to be == expect_output
    end
  end

  it "should be verify the Export/Print button functionality::Tny1641296c" do

    on ErrorsandDiscardsPage do |page|
      expect_output=interface_serv['report_option']
      expect(page.interface_exportReport_icon).to be == expect_output
    end
  end

  it "should be Verify the File Format Report icon in quickview::Tny1641297c" do

    on ErrorsandDiscardsPage do |page|
      expect_output=interface_serv['export_formeta']
      expect(page.interface_export_format).to be == expect_output
      #       page.interface_export_format.should include expect_output
    end
  end

  it "should be Verify the Print option in Report icon in quickview::Tny1641298c" do

    on ErrorsandDiscardsPage do |page|
      #       expect_output=interface_serv['print_text']
      #       page.interface_report_print.should include expect_output
      page.interface_report_print
    end
  end

  it "should be Verify the Detailed Report features in quickview::Tny1641299c" do

    on ErrorsandDiscardsPage do |page|
      page.scheduleReport_feature
      expect(page).to be_true
    end
  end

  it "should be Verify the Detailed Report formet::Tny1641300c" do

    on ErrorsandDiscardsPage do |page|

      expect_output=interface_serv['export_formetb']
      expect(page.scheduleReport_format).to be == expect_output
    end
  end

  it "should be verify the schedule report::Tny1641311c" do

    on ErrorsandDiscardsPage do |page|
      page.schedule_report
      sleep 2
      page.expect_toaster("Report Schedule updated successfully.")
    end

  end

  it "should be Verify the PIN icon in quickview::Tny1641315c" do

    on ErrorsandDiscardsPage do |page|

      expect_output=interface_serv['pin_title']
      page.interface_pin.should include expect_output
    end
  end

  it "should be Verify the Close-icon in quickview::Tny1641317c" do

    on ErrorsandDiscardsPage do |page|
      page.quickview_closepopup
      expect(page).to be_true
    end
  end

  it "should be Verify the interface details chart icons in quickview ::Tny1641290c" do

    on ErrorsandDiscardsPage do |page|
      expect=errors_serv['detailview_pagetitle']
      page.interface_detailview.should include expect
    end
  end

  it "should be Verify the interface details chart icons in quickview ::Tny1836089c" do   ## Regression Testcase

    on ErrorsandDiscardsPage do |page|

      expect=errors_serv['detailview_pagetitle']
      page.interface_detailview.should include expect
    end
  end

end

describe "US10549-Errors & Discards" do

  before :all do
    visit ErrorsandDiscardsPage
  end

  it "should be Verify errors and discards table count and Last updated time::Tny1642675c" do
    on ErrorsandDiscardsPage do |page|
      new_tab = "Errors and Discards"
      page.select_dashboard_tab(new_tab)
      expect=Time.now.strftime("%b%e, %Y")
      expect(page.errorTable_date_noRecords).to be == expect
    end
  end

  it "should be verify show option in the table-Filter::Tny1642676c" do

    on ErrorsandDiscardsPage do |page|
      expect_output=interface_serv['filter_option']
      expect(page.errorDiscard_show_option_filter).should == expect_output
    end
  end

  it "should be verify table quick view option::Tny1642680c" do

    on InterfaceUtilizationPage do |page|
      page.errorDiscards_quick_filter
      page.filterBox_element.should be_present
    end
  end

  it "should be verify export option::Tny1642678c" do

    on ErrorsandDiscardsPage do |page|
      expect_output=interface_serv['export_formetc']
      expect(page.errorDiscardTable_export).to match_array(expect_output)
    end
  end

  it "should be verify table content::Tny1642679c" do

    on ErrorsandDiscardsPage do |page|
      #         expect_output=interface_serv['errorDiscrds_columnName']
      #         expect(page.errorDiscardTable_columnName).to include (expect_output)
      page.errorDiscardTable_columnName.should include "In Discards"
    end
  end

  it "should be verify table record count::Tny1642683c" do

    on ErrorsandDiscardsPage do |page|
      page.errorDiscardTable_rowCount
      expect(page).to be_true
    end
  end

end

describe "US11075---Errors & Discards" do

  before :all do
    visit ErrorsandDiscardsPage
  end

  it "should be Verify the filter options::Tny1640829c" do
    on ErrorsandDiscardsPage do |page|
      new_tab = "Errors and Discards"
      page.select_dashboard_tab(new_tab)
      expect_output=interface_serv['filter']
      expect(page.errorDiscards_Filter).to match_array(expect_output)
    end
  end

  it "should be Verify the Interface Group filter with System Defined (Table)::Tny1640840c/Tny1640844c/Tny1640845c" do

    on ErrorsandDiscardsPage do |page|
      expect(page.errorsDiscards_interfaceGroupTable).not_to be_empty
    end
  end

  it "should be Verify the Location filter with SanJose (Table)::Tny1640838c/Tny1640842c/Tny1640846c" do
    on ErrorsandDiscardsPage do |page|
      expect(page.errorsDiscards_locationTable).not_to be_empty
    end
  end

  it "should be Verify the Duration filter with Last 7days (Table)::Tny1640836c" do
    on ErrorsandDiscardsPage do |page|
      expect(page.errorsDiscards_7DaysTableData).not_to be_empty
    end
  end

  it "should be Verify the Duration filter with All option (Table)::Tny1640837c" do
    on ErrorsandDiscardsPage do |page|
      expect(page.errorsDiscards_14DaysTableData).not_to be_empty
    end
  end

  it "should be Verify add and Remove filters in Dashboards::Tny1836145c" do
    on ErrorsandDiscardsPage do |page|
      page.filter_element.wd.location_once_scrolled_into_view
      page.setting_element.when_present.flash.click
      page.filterMenu_element.when_present.flash.click
      page.duration_element.when_present.flash.click
      page.location_element.when_present.flash.click
      page.interfaceGroup_element.when_present.flash.click
      sleep 3
      page.duration_element.when_present.flash.click
      page.location_element.when_present.flash.click
      page.interfaceGroup_element.when_present.flash.click
      expect_output=interface_serv['filter']
      expect(page.errorDiscards_Filter).to match_array(expect_output)
    end
  end

end

describe "US10551---Erros and Discards" do

  before :all do
    visit ErrorsandDiscardsPage
  end

  it "should be Verify detailed Analysis Page Launch of the interface chosen and its details ( Date)::Tny1648235c/Tny1648256c" do
    on ErrorsandDiscardsPage do |page|
      new_tab = "Errors and Discards"
      page.select_dashboard_tab(new_tab)
      page.errorsDiscardsDetailview_Date
    end
  end

  it "should be Verify Detailed Analysis Page Launch of the interface chosen and Graph Y Axis, calculation mode as Absolute::Tny1648236c" do
    on InterfaceUtilizationPage do |page|
      page.errorsDiscardsDetailview_CalculationMode.should include "Rate (Mbps)"
    end
  end

  it "should be Verify Detailed Analysis page has been Launched and X axis (date) in the Graph has necessary values::Tny1648238c" do
    on InterfaceUtilizationPage do |page|
      page.interfaceDetailview_ChartXaxisDate
      expect(page).to be_true
    end
  end

  it "Verify Detailed Analysis Page Graph Legend::Tny1648239c" do
    on InterfaceUtilizationPage do |page|
      page.interfaceDetailview_GraphLegend
      expect(page).to be_true
    end
  end

  it "Verify Detailed Analysis Page graph Legend - Enable/disable::Tny1648241c" do
    on InterfaceUtilizationPage do |page|
      page.interfaceDetailview_GraphLegendEnableDiable
      expect(page).to be_true
    end
  end

  it "Verify Detailed Analysis Page graph - Mouse Hover::Tny1648242c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceDetailview_GraphValue).not_to be_empty
    end
  end

  it "Verify the paging details are being displayed below the date range Bar::Tny1648244c" do
    on InterfaceUtilizationPage do |page|
      expect(page.errorsDiscardsDetailview_PagingDetails).to be_true
    end
  end

  it "Verify the Filters option are getting collapsed and decollapse based on the choice we are selecting::Tny1648246c" do
    on InterfaceUtilizationPage do |page|
      page.interfaceDetailsview_FilterCollapseDecollapse
      expect(page).to be_true
    end
  end

  it "Verify the Duration dropdown list shows the same list as shown in dashboard page::Tny1648248c" do
    on InterfaceUtilizationPage do |page|
      expect_output=interface_serv['detailView_duration']
      expect(page.interfaceDetailsview_timePeriod).to match_array(expect_output)
    end
  end

  it "Verify the Devices and Interfaces tabs are showing as Multiple selections when more than 2 items are selected from the dropdown::Tny1648251c" do
    on InterfaceUtilizationPage do |page|
      page.interfaceDetailsview_multipleSelection
      expect(page).to be_true
    end
  end

  it "Verify the Graphs have been generated in the Detailed analysis page based on the filter selection::Tny1648252c" do
    on InterfaceUtilizationPage do |page|
      expect(page.errosDiscardsDetailview_FilterSelectionData).not_to be_empty
    end
  end

  it "Verify the Merged Graph is showing with both the chart and its Value along with Legend::Tny1648255c" do
    on InterfaceUtilizationPage do |page|
      expect(page.interfaceUtilDetailview_MergedData).not_to be_empty
    end
  end

  it "Verify the Detailed analysis page has been added as a Favorite  in Toogle Navigation::Tny1648245c" do
    on InterfaceUtilizationPage do |page|
      expect=errors_serv['detailview_pagetitle']
      expect(page.interfaceUtilDetailview_AddFavourite).to include(expect)

    end
  end

  it "Verify the Verify By Timeperiod  filter is similar to Global Filter::Tny1847859c" do
    on ErrorsandDiscardsPage do |page|
      expect(page.detailVewTimeperiodFilter_GlobalFilter).to be_true
    end
  end

  it "Verify Devices and Interface field has the devicename what we have selected in Detailed View Page::Tny1847860c" do
    on ErrorsandDiscardsPage do |page|
      expect(page.detailVew_DevicesInterfaces).to be_true
    end
  end

  it "Verify Devices and Interfaces field updated as ALL once we sleceted  Location  as ALL::Tny1847861c" do
    on ErrorsandDiscardsPage do |page|
      expect_output=["All","All"]
      expect(page.detailView_DevicesInterfaces_FilterALLOption).to match_array(expect_output)
    end
  end

  it "Verify the Graph generated for the selected interface having IN Errors & Out Errors selected in filter option::Tny1847841c" do
    on ErrorsandDiscardsPage do |page|
      expect(page.detailView_Graph_InErrorsOutErrors).not_to be_empty
    end
  end

  it "Verify the RESET button is regaining to the original position for  Devices field after do some changes in that field::Tny1847842c" do
    on ErrorsandDiscardsPage do |page|
      expect(page.detailView_ResetDeviceField).to be_true
    end
  end

  it "Verify Reset Button is regaining the default values of the field in detail view calculation mode Graph View::Tny1847843c" do
    on ErrorsandDiscardsPage do |page|
      expect(page.detailView_ResetClaculationModeGraphView).to be_true
    end
  end

  it "Verify Scheduled report is working for interface utilization Detail View::Tny1847845c" do
    on ErrorsandDiscardsPage do |page|
      page.interface_ScheduleReport
      sleep 2
      page.expect_toaster("Report Schedule updated successfully.")
    end
  end

end