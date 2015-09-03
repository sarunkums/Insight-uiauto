require 'spec_helper.rb'

usecase_service = YAML::load(File.open("data/usecase_service.yml"))
qos_serv = usecase_service['qos_service'][0]
interface_serv = usecase_service['common_attribute'][0]
interUtil_serv = usecase_service['interface_Utilization_service'][0]

describe "US10688-Home Menu-QOS Classes" do

  before :all do
    visit QOS
  end

  it "should be Verify the Qos Classes filters::Tny1653411c" do
    on QOS do |page|
      new_tab = "QoS Classes"
      page.select_dashboard_tab(new_tab)
      expect_output=qos_serv['filter_qos']
      expect(page.qos_Filter).to match_array(expect_output)
    end
  end

  it "should be able to Verify QOS classmap filter options::Tny1653412c" do
    on QOS do |page|
      expect_output=qos_serv['qosClassmap_filter']
      expect(page.qosClassmap_Filter).to match_array(expect_output)
    end
  end

  it "should be able to Verify the QOS Classes table::Tny1653413c" do
    on QOS do |page|
      expect_output=qos_serv['table_ColumnName']
      expect(page.qosTable_ColumnName).to match_array(expect_output)
    end
  end

  it "should be able to Verify the QOS Classes table sorting for the new options Drops::Tny1653414c" do
    on QOS do |page|
      expect(page.qostable_sorting).to be_true
    end
  end

  it "should be able to Verify Classmap filter option with All and multiple selection of Site Group and Interface Group::Tny1653415c" do

    on QOS do |page|
      expect(page.classmapFilter_AllOption).to be_true
    end

  end

  it "should be able to Verify Classmap filter option with QPM_PQ::Tny1653416c" do

    on QOS do |page|
      expect(page.classmapFilter_QPM_PQ_Option).to be_true
    end

  end

  it "should be able to Verify QoS Classmap filter option with QPM_PQ and Duration filter with all duration options::Tny1653417c" do

    on QOS do |page|
      expect(page.classmapFilter_QPM_PQ_Option_DurarionAllOptions).to be_true
    end

  end

  it "should be able to Verify Classmap filter option with class-default::Tny1653418c" do

    on QOS do |page|
      expect(page.classmapFilter_ClassDefault_Option).to be_true
    end
  end

  it "should be able to Verify Classmap filter option with class-default and Duration filter with all duration options::Tny1653419c" do

    on QOS do |page|
      expect(page.classmapFilter_ClassDefault_DurationAllOptions).to be_true
    end
  end

  it "should be able to Verify Classmap filter option with All and Duration filter with all duration options::Tny1653421c" do

    on QOS do |page|
      expect(page.classmapFilterAllOption_DurationAllOptions).to be_true
    end
  end

  it "should be able to Verify QOS Classes tab Quick Filter::Tny1653422c" do

    on QOS do |page|

      expect(page.qosClasses_QuickFilter).to include("QPM_PQ")

    end
  end

  it "Should be able to Verify Interface Name Info icon_i from QOS classes table::Tny1653428c" do

    on QOS do |page|
      expect_output=interface_serv['chart_icon']
      expect(page.interfaceQuickview_Footericons).to match_array(expect_output)
    end
  end

  it "Should be able to Verify click on Detailed view icon from Interface Name table info_i::Tny1653429c" do

    on QOS do |page|
      expect=interUtil_serv['detailview_pagetitle']
      page.interfaceName_DetailedView.should include expect
    end
  end

  it "Should be able to Verify click on info icon_i from Class Name table::Tny1653430c" do

    on QOS do |page|
      expect_output=interface_serv['chart_icon']
      expect(page.classNameQuickview_Footericons).to match_array(expect_output)
    end
  end

  it "Should be able to Verify Class Name table info window icons Chart Mode,Grid Mode::Tny1653431c" do

    on QOS do |page|
      expect_output=qos_serv['qosClassmap_QuickViewQOSTableColumnName']
      expect(page.classNameQuickview_ChartGridMode).to be == expect_output
    end
  end

  it "Should be able to Verify Class Name table info window Chart view,Export/print, and Details view::Tny1653431c" do

    on QOS do |page|
      expect_output=interface_serv['report_option']
      expect(page.classNameQuickview_ChartTypeExportPrint).to be == expect_output
    end
  end

  it "should be Verify the PIN icon in quickview::Tny1653431c" do

    on QOS do |page|
      expect_output=interface_serv['pin_title']
      page.interface_pin.should include expect_output
    end
  end

  it "should be Verify the Close-icon in quickview::Tny1653431c" do

    on QOS do |page|
      expect(page.quickview_closepopup).to be_true
    end
  end

  it "should be able to verify the class name and interface name i icon display when de-selecting and selecting column::Tny1653584c" do
    on QOS do |page|
      expect(page.qosClasses_setting).to be_true
    end
  end

  it "Should be able to Verify click on Detailed view icon from QOS Classes Name table info (i)::Tny1653433c" do

    on QOS do |page|
      expect=qos_serv['detailview_pagetitle']
      page.qosClasses_DetailedView.should include expect
    end
  end

end

describe "US10689-Home Menu-QOS Classes" do

  before :all do
    visit QOS
  end

  it "should be able to Verify the QOS Classes Interface Name Quick View pop up window should displayed as Chart mode::Tny1653435c" do
    on QOS do |page|
      new_tab = "QoS Classes"
      page.select_dashboard_tab(new_tab)
      page.qosClasses_InterfaceChartNode
      sleep 2
      page.chart_element.should be_present
    end
  end
  it "should be able to Verify  the QOS Classes Quick View Interface Utilization Chart::Tny1653436c" do
    on QOS do |page|
      expect(page.interfcaeQuickViewChart_XandY_AxisLabel).to be_true
    end
  end

  it "should be  Verify the QOS Classes Quick View Interface Utilization Chart mouse over::Tny1653437c" do

    on QOS do |page|
      expect(page.qosClassesChart_allTooltip).not_to be_empty
    end
  end

  it "should be able to Verify the QOS Classes Interface title in Quick View Interface Utilization window::Tny1653438c" do
    on QOS do |page|
      expect(page.qosClasses_interfaceQuickViewTitle).to be_true
    end
  end

  it "should be Verify the QOS Classes Quick View Interface Utilization Date and Time::Tny1653439c" do

    on QOS do |page|
      expectDate=Time.now.strftime("%b %e, %Y")
      expect(page.qosClassesquickview_InterfaceDate).to be == expectDate
    end
  end

  it "should be Verify the QOS Classes Quick View Interface Utilization Chart Mode and grid Mode::Tny1653440c" do

    on QOS do |page|
      page.gridButoon_element.when_present(5).flash.click
      page.grid_element.should be_present
      page.chartButoon_element.when_present(5).flash.click
      page.chart_element.should be_present
    end
  end

  it "Should be able to Verify the QOS Classes Quick View Interface Utilization Grid Mode::Tny1653441c" do

    on QOS do |page|
      expect_output=qos_serv['qosClassmap_QuickViewInterfaceTableColumnName']
      expect(page.qosClassesquickview_InterfaceGridNodeColumnName).to be == expect_output
    end
  end

  it "should be Verify the QOS Classes Quick View Interface Utilization Grid View sort option::Tny1653442c" do

    on QOS do |page|
      expect(page.interfaceGrid_sorting).to be_true
    end
  end

  it "should be Verify the QOS Classes Quick View Interface Utilization Export to CSV::Tny1653444c" do

    on QOS do |page|

      expect(page.classNameQuichView_ExportCSVFormet).not_to be_empty

    end
  end

  it "should be Verify the QOS Classes Quick View Interface Utilization Schedule Report Option::Tny1653446c" do

    on QOS do |page|
      page.exportPrintButoon_element.when_present(5).flash.click
      page.scheduleReport_element.when_present(5).flash.click
      page.popup_element.should be_present
      page.schedule_report
      page.expect_toaster("Report Schedule updated successfully.")
    end
  end

  it "should be able to Verify the QOS Classes Quick View Class map Chart ::Tny1653450c" do
    on QOS do |page|
      page.qosClasses_ClassNameChartNode
      page.interfaceClassPopupID_element.should be_present
      page.chart_element.should be_present
    end
  end

  it "should be able to Verify the QOS Classes Quick View ClassName map Chart-X and Y Axis::Tny1653451c" do
    on QOS do |page|
      page.classNameQuickViewChart_XandY_AxisLabel
      expect(page).to be_true
    end
  end

  it "should be able to Verify the QOS Classes Quick View Class map Chart mouse over for All Date::Tny1653451c" do

    on QOS do |page|
      expect(page.qosClassesChart_allTooltip).not_to be_empty
    end
  end

  it "should be able to Verify the QOS Classes Quick View ClassName map Chart Chart-for Particular Date::Tny1653452c" do

    on QOS do |page|
      expect(page.qosClassesChart_PerticularTooltip).not_to be_empty
    end
  end

  it "should be able to Verify the QOS Classes Class Name Title in Quick View::Tny1653453c" do
    on QOS do |page|
      page.qosClasses_ClassQuickViewTitle
      expect(page).to be_true
    end
  end

  it "should be Verify the QOS Classes Quick View Class map Date and Time::Tny1653454c" do

    on QOS do |page|
      expectDate=Time.now.strftime("%b %e, %Y")
      expect(page.qosClassesquickview_InterfaceDate).to be == expectDate
    end
  end

  it "should be Verify the QOS Classes Quick View Class map Chart Mode and grid Mode::Tny1653455c" do

    on QOS do |page|
      page.gridButoon_element.when_present(5).flash.click
      page.grid_element.should be_present
      page.chartButoon_element.when_present(5).flash.click
      page.chart_element.should be_present
    end
  end

  it "should be Verify the QOS Classes Quick View Class map Grid View sort option::Tny1653457c" do

    on QOS do |page|
      expect(page.interfaceGrid_sorting).to be_true
    end
  end

  it "should be Verify the QOS Classes Quick View Class map Export to CSV::Tny1653459c" do

    on QOS do |page|

      expect(page.classNameQuichView_ExportCSVFormet).not_to be_empty

    end
  end

  it "should be Verify the QOS Classes Quick View Class map Schedule Report Option::Tny1653461c" do

    on QOS do |page|
      page.exportPrintButoon_element.when_present(5).flash.click
      page.scheduleReport_element.when_present(5).flash.click
      page.popup_element.should be_present
      page.schedule_report
      page.expect_toaster("Report Schedule updated successfully.")
    end
  end

  it "should be Verify the QOS Classes Quick View Class map Pin/Unpin option::Tny1653464c" do

    on QOS do |page|
      expect_output=interface_serv['pin_title']
      page.interface_pin.should include expect_output
    end
  end

end

describe "US10690-Home Menu-QOS Classes" do

  before :all do
    visit QOS
  end

  it "Should be able to Verify Detailed Analysis page has been Launched while selecting the Detailed View from the Classname Quickview page of the QoS classes::Tny1654627c" do
    on QOS do |page|
      new_tab = "QoS Classes"
      page.select_dashboard_tab(new_tab)
      page.qosClasses_ClassNameQuickView
      expect=qos_serv['detailview_pagetitle']
      page.qosClasses_DetailedView.should include expect
    end
  end

  it "should be Verify the Graph has been generated with the Interface name which was Corresponding to the classname in Quick View::Tny1654628c" do

    on QOS do |page|
      page.classNameDetailView_InterfaceTitle
      expect(page).to be_true
      page.firstInterfaceChart_element.should be_present
    end
  end

  it "should be Verify the Graphs has been generated with the date (from - to) which was displayed in Quick View::Tny1654629c" do
    on QOS do |page|
      page.qosDetailview_Date
      expect(page).to be_true
    end
  end

  it "should be Verify Detailed Analysis page has been Launched and X axis (date) in the Graphs have necessary values Post policy Octate Rate,Pre policy Octate Rate,Drop octate Rate::Tny1654630c" do
    on QOS do |page|
      sleep 3
      page.qosInterfaceTitle1_element.wd.location_once_scrolled_into_view
      page.firstInterfaceChart_element.should be_present
      page.qosInterfaceTitle2_element.wd.location_once_scrolled_into_view
      page.secondInterfaceChart_element.should be_present
      page.qosInterfaceTitle3_element.wd.location_once_scrolled_into_view
      page.thirdInterfaceChart_element.should be_present
    end
  end

  it "should be Verify the Chart in the graph has been changed as per the enabling/disabling the legend::Tny1654631c" do
    on QOS do |page|
      expect(page.qosDetailview_GraphLegendEnableDiable).to be_true
    end
  end

  it "should be Verify the Values are shown during the mouse hover over the chart in the graph::Tny1654632c" do
    on QOS do |page|
      expect(page.qosDetailview_GraphValue).not_to be_empty
    end
  end

  it "should be Verify the Devices group tabs are showing as Multiple selections when 2 or more than 2 items are selected from the dropdown::Tny1654637c" do
    on QOS do |page|
      expect(page.qosDetailsview_multipleSelection).to be_true
    end
  end

  it "should be Verify the paging details are being displayed below the date range Bar::Tny1654638c" do
    on QOS do |page|
      expect(page.qosDetailview_PagingDetails).to be_true
    end
  end

  it "should be Verify the Duration dropdown list shows the same list as shown in dashboard page::Tny1654643c" do
    on QOS do |page|
      expect_output=interface_serv['detailView_duration']
      expect(page.qosDetailsview_timePeriod).to match_array(expect_output)
    end
  end

  it "Should be Verify the Filters option are getting collapsed and decollapse based on the choice we are selecting::Tny1654644c" do
    on QOS do |page|
      expect(page.qosDetailsview_FilterCollapseDecollapse).to be_true
    end
  end

  it "Should be Verify the Grid Mode in Detailed Analysis Page::Tny1654649c" do
    on QOS do |page|
      expect(page.qosDetailsview_GridMode).not_to be_empty
    end
  end

  it "should be Verify the Sorting of data in the Grid Mode in Detailed Analysis Page::Tny1654650c" do

    on QOS do |page|
      expect(page.qosDetailViewGrid_sorting).to be_true
    end
  end

  it "should be Verify the DA Page Export to CSV Option::Tny1654652c" do

    on QOS do |page|
      expect(page.qosDetailView_ExportCSVFormet).not_to be_empty
    end
  end

  it "should be Verify the Interfaces filter options::Tny1654659c" do

    on QOS do |page|

      expect(page.qosDetailView_InterfaceGroup).not_to be_empty
    end
  end

  it "should be Verify the DA Page Chart Type Option::Tny1654654c" do

    on QOS do |page|
      expect(page.qosDetailView_ChartType).not_to be_empty
    end
  end

  it "should be Verify the Site Group filter options::Tny1654657c" do

    on QOS do |page|
      expect(page.qosDetailView_SiteGroup).not_to be_empty
    end
  end

end

describe "US13048-QOS Classes-Miscellaneous tasks" do

  before :all do
    visit QOS
  end

  it "should be Verify QOS DetailView chart have 4 icons (Chart mode, Grid Mode, Chart Types, Schedule Report)::Tny1662709c" do
    on QOS do |page|
      new_tab = "QoS Classes"
      page.select_dashboard_tab(new_tab)
      expect(page.qosDetailView_ChartBottomIcons).to include("Chart Mode", "Chart Types", "Export", "Grid Mode")
    end
  end

  it "should be Verify Grid Mode Icons in Graphs in Detailed View QoS Class map::Tny1662720c" do
    on QOS do |page|
      page.firstChartGridMode_element.flash.click
      page.firstInterfacegrid_element.wd.location_once_scrolled_into_view
      page.firstInterfacegrid_element.should be_present
    end
  end

  it "should be Verify Chart Mode Icons in Graphs in Detailed View QoS Class map::Tny1662719c" do
    on QOS do |page|
      page.firstChartMode_element.flash.click
      page.firstInterfaceChart_element.should be_present
    end
  end

  it "should be Verify Chart Types Icons in Graphs in Detailed View QoS Class map::Tny1662721c" do
    on QOS do |page|
      page.firstChartMode_element.flash.click
      page.firstCharTypes_element.should be_present
    end
  end

  it "should be Verify Export Icons in Graphs in Detailed View QoS Class map::Tny1662722c" do
    on QOS do |page|
      expect(page.qosDetailView_ExportCSVFormet).not_to be_empty
    end
  end

  it "should be Verify Custom Period in Graphs in Detailed View QoS Class map::Tny1662723c" do
    on QOS do |page|
      page.dateLink_element.flash.click
      page.datePopUpTitle_element.flash
      page.datePopUpTitle_element.should be_present
    end
  end

end

