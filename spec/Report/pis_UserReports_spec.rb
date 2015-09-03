require 'spec_helper'

describe "US19755-Prime Insight Users Based Report Creation" do

  before :all do
    visit PISuserReport
  end

  it "Verify Globaladmin User can scheduled the report from If Util - from Chart::Tny1889069c" do

    on PISuserReport do |page|
      new_tab = "Interface Utilization"
      page.select_dashboard_tab(new_tab)
      reportTitle="Globaladmin_InterfaceChart_Report"
      page.scheduleRport_FromChart(reportTitle)
      sleep 2
      page.expect_toaster("Report Schedule updated successfully.")
      expect(page.reportTitleIn_scheduleReport(reportTitle)).to be_true
    end
  end

  it "Verify Globaladmin User can scheduled the report from If Util - QV::Tny1889071c" do

    on PISuserReport do |page|
      reportTitle="Globaladmin_InterfaceQuickView_Report"
      page.scheduleRport_FromInterfaceUtilQuickView(reportTitle)
      sleep 2
      page.expect_toaster("Report Schedule updated successfully.")
      expect(page.reportTitleIn_scheduleReport(reportTitle)).to be_true
    end
  end

  it "Verify Globaladmin User can scheduled the report from If Util - DV::Tny1889073c" do

    on PISuserReport do |page|
      reportTitle="Globaladmin_InterfaceDetailView_Report"
      page.scheduleRport_FromIntrfaceUtilDetailView(reportTitle)
      sleep 2
      page.expect_toaster("Report Schedule updated successfully.")
      expect(page.reportTitleIn_scheduleReport(reportTitle)).to be_true
    end
  end

  it "Verify Globaladmin User can scheduled the report from Error & Discard Quick View::Tny1889079c" do

    on PISuserReport do |page|
      reportTitle="Globaladmin_ErrorsDiscardsQuickView_Report"
      tab="Errors and Discards"
      indexQV=0
      page.scheduleRport_QuickView(reportTitle,tab,indexQV)
      sleep 2
      page.expect_toaster("Report Schedule updated successfully.")
      expect(page.reportTitleIn_scheduleReport(reportTitle)).to be_true
    end
  end

  it "Verify Globaladmin User can scheduled the report from Error & Discard Detailed View::Tny1889081c" do

    on PISuserReport do |page|
      reportTitle="Globaladmin_ErrorsDiscardsDetailView_Report"
      tab="Errors and Discards"
      indexQV=0
      page.scheduleRport_DetailView(reportTitle,tab,indexQV)
      sleep 2
      page.expect_toaster("Report Schedule updated successfully.")
      expect(page.reportTitleIn_scheduleReport(reportTitle)).to be_true
    end
  end

  it "Verify Globaladmin User can scheduled the report from QOS: Utilization Quick View::Tny1889083c" do

    on PISuserReport do |page|
      reportTitle="Globaladmin_QOSInterfaceQuickView_Report"
      tab="QoS Classes"
      indexQV=0
      page.scheduleRport_QuickView(reportTitle,tab,indexQV)
      expect(page.reportTitleIn_scheduleReport(reportTitle)).to be_true
    end
  end

  it "Verify Globaladmin User can scheduled the report from QOS: Utilization Detailed View::Tny1889085c" do

    on PISuserReport do |page|
      reportTitle="Globaladmin_QOSInterfaceDetailView_Report"
      tab="QoS Classes"
      indexQV=0
      page.scheduleRport_DetailView(reportTitle,tab,indexQV)
      expect(page.reportTitleIn_scheduleReport(reportTitle)).to be_true
    end
  end

  it "Verify Globaladmin User can scheduled the report from QOS: QOS Quick View::Tny1889087c" do

    on PISuserReport do |page|
      reportTitle="Globaladmin_QOSClassQuickView_Report"
      tab="QoS Classes"
      indexQV=1
      page.scheduleRport_QuickView(reportTitle,tab,indexQV)
      expect(page.reportTitleIn_scheduleReport(reportTitle)).to be_true
    end
  end

  it "Verify Globaladmin User can scheduled the report from QOS: QOS Detailed View::Tny1889089c" do

    on PISuserReport do |page|
      reportTitle="Globaladmin_QOSClassInterfaceDetailView_Report"
      tab="QoS Classes"
      indexQV=1
      page.scheduleRport_DetailView(reportTitle,tab,indexQV)
      expect(page.reportTitleIn_scheduleReport(reportTitle)).to be_true
    end
  end
  # Report Creation For Creator
  it "Verify Report Creator User can scheduled the report from If Util - from Chart::Tny1889070c" do

    on PISuserReport do |page|
      page.accountCreation_reportCreatorViewer
      sleep 5
      reportTitle="Creator_InterfaceChart_Report"
      page.scheduleRport_FromChart(reportTitle)
      sleep 2
      page.expect_toaster("Report Schedule updated successfully.")
      expect(page.reportTitleIn_scheduleReport(reportTitle)).to be_true
    end
  end

  it "Verify Report Creator User can scheduled the report from If Util - QV::Tny1889072c" do

    on PISuserReport do |page|
      reportTitle="Creator_InterfaceQuickView_Report"
      page.scheduleRport_FromInterfaceUtilQuickView(reportTitle)
      sleep 2
      page.expect_toaster("Report Schedule updated successfully.")
      expect(page.reportTitleIn_scheduleReport(reportTitle)).to be_true
    end
  end

  it "Verify Report Creator User can scheduled the report from If Util - DV::Tny1889074c" do

    on PISuserReport do |page|
      reportTitle="Creator_InterfaceDetailView_Report"
      page.scheduleRport_FromIntrfaceUtilDetailView(reportTitle)
      sleep 2
      page.expect_toaster("Report Schedule updated successfully.")
      expect(page.reportTitleIn_scheduleReport(reportTitle)).to be_true
    end
  end

  it "Verify Creator User can scheduled the report from Error & Discard Quick View::Tny1889080c" do

    on PISuserReport do |page|
      reportTitle="Creator_ErrorsDiscardsQuickView_Report"
      tab="Errors and Discards"
      indexQV=0
      page.scheduleRport_QuickView(reportTitle,tab,indexQV)
      sleep 2
      page.expect_toaster("Report Schedule updated successfully.")
      expect(page.reportTitleIn_scheduleReport(reportTitle)).to be_true
    end
  end

  it "Verify Creator User can scheduled the report from Error & Discard Detailed View::Tny1889082c" do

    on PISuserReport do |page|
      reportTitle="Creator_ErrorsDiscardsDetailView_Report"
      tab="Errors and Discards"
      indexQV=0
      page.scheduleRport_DetailView(reportTitle,tab,indexQV)
      sleep 2
      page.expect_toaster("Report Schedule updated successfully.")
      expect(page.reportTitleIn_scheduleReport(reportTitle)).to be_true
    end
  end

  it "Verify Creator User can scheduled the report from QOS: Utilization Quick View::Tny1889084c" do

    on PISuserReport do |page|
      reportTitle="Creator_QOSInterfaceQuickView_Report"
      tab="QoS Classes"
      indexQV=0
      page.scheduleRport_QuickView(reportTitle,tab,indexQV)
      expect(page.reportTitleIn_scheduleReport(reportTitle)).to be_true
    end
  end

  it "Verify Creator User can scheduled the report from QOS: Utilization Detailed View::Tny1889086c" do

    on PISuserReport do |page|
      reportTitle="Creator_QOSInterfaceDetailView_Report"
      tab="QoS Classes"
      indexQV=0
      page.scheduleRport_DetailView(reportTitle,tab,indexQV)
      expect(page.reportTitleIn_scheduleReport(reportTitle)).to be_true
    end
  end

  it "Verify Creator User can scheduled the report from QOS: QOS Quick View::Tny1889088c" do

    on PISuserReport do |page|
      reportTitle="Creator_QOSClassQuickView_Report"
      tab="QoS Classes"
      indexQV=1
      page.scheduleRport_QuickView(reportTitle,tab,indexQV)
      expect(page.reportTitleIn_scheduleReport(reportTitle)).to be_true
    end
  end

  it "Verify Creator User can scheduled the report from QOS: QOS Detailed View::Tny1889090c" do

    on PISuserReport do |page|
      reportTitle="Creator_QOSClassInterfaceDetailView_Report"
      tab="QoS Classes"
      indexQV=1
      page.scheduleRport_DetailView(reportTitle,tab,indexQV)
      expect(page.reportTitleIn_scheduleReport(reportTitle)).to be_true
    end
  end

  it "Verify The Report viewer user can able to schedule the report::Tny1889076c" do

    on PISuserReport do |page|
      expect="Sorry , Report Viewer Cannot Schedule a view."
      expect(page.scheduleReport_ReportViewer).to eq(expect)
    end
  end

end