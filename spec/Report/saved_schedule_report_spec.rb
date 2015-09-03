require 'spec_helper'

base_service = YAML::load(File.open("data/base_service.yml"))
report_template_serv = base_service['report_templates_service'][0]
schedule_report_serv = base_service['scheduled_reports_service'][0]

describe "US6501-ReportTemplate & ScheduleReport" do

  before :all do

    visit SavedReportPage

  end

  it "should be able Verify the mandatory fields in schedule reports::Tny1639328c" do

    on SavedReportPage do |page|
      page.schedule_element.when_present.flash.click
      page.report_title_element.clear
      sleep 5
      page.save_element.when_present(15).flash.click
      sleep 3
      expect_output=report_template_serv['report_title_empty']
      expect(page.titlealerttext_element.text).to be == expect_output

    end

  end

  it "should be able to Verify the Schedule reports in CSV Format::Tny1639329c" do

    on SavedReportPage do |page|
      page.titlealertok_element.when_present.flash.click
      page.cancel_element.when_present.flash.click
      page.schedule_element.when_present.flash.click
      page.csv_element.when_present.flash.click
      page.report_csv.should be_true
    end

  end

  it "should be able to Verify the Schedule reports in PDF Format::Tny1639330c" do

    on SavedReportPage do |page|
      page.cancel_element.when_present.flash.click
      page.schedule_element.when_present.flash.click
      page.pdf_element.when_present.flash.click
      page.report_pdf.should be_true
    end

  end

  it "should be able to Verify the Start date selected in Schedule reports page ::Tny1639332c" do

    on SavedReportPage do |page|
      page.startdate_element.when_present.flash.click
      page.calendarbody_element.should be_present
    end
  end

  it "should be able to Verify the number of Schedules count in Report Template page::Tny1639333c" do

    on SavedReportPage do |page|
      #      expect_output=page.no_scheduleText_element.text
      #      expect(page.scheduleReport_count).to be == expect_output
      page.cancel_element.when_present(5).flash.click
      page.scheduleReport_count.should be_true
    end

  end

  it "should be able to Verify the quick filter option in Report Template UI::Tny1639344c & Tny1639346c & Tny1639347c" do

    on SavedReportPage do |page|
      sleep 2
      page.reportquick_filter.should be_true
    end

  end

  it "should be able to verify Toaster popup displayed after scheduling the report::Tny1642306c" do

    on SavedReportPage do |page|
      page.scheduleReport_Toster
      sleep 2
      page.expect_toaster('Report Schedule updated successfully.')
    end

  end

  it "should be able to Verify the scheduled button is disabled , when no report is selected in Report Template UI::Tny1642641c" do

    on SavedReportPage do |page| # Here am checking "Schedule" button disable functionality
      page.radio_row1_element.when_present(3).flash.click
      sleep 3
      page.button_enabled?(page.schedule_element).should be_false
    end
  end

  it "should be able to Verify the user can able to suspend the report::Tny1639335c" do

    on ScheduledReportsPage do |page|
      page.suspend_report
      expect_output=schedule_report_serv['report_suspended']
      expect(page.nextruntimeText_element.text).to be == expect_output
      #      page.suspend_report.should == "Suspended"
    end
  end

  it "should be able to Verify the user can able to resume the report::Tny1639336c" do

    on ScheduledReportsPage do |page|
      page.resume_report
      expect_output=schedule_report_serv['report_suspended']
      expect(page.nextruntimeText_element.text).not_to be == expect_output
      #      page.resume_report.should_not == "Suspended"
    end
  end

  it "should be able to Verify the End date in Schedule Reports::Tny1639342c" do

    on ScheduledReportsPage do |page|

      page.scheduleReport_enddate
      #      sleep 3
      #      expect(page.enddateTextBox_element.value).to be == Time.now.strftime("%m/%d/%y")
    end
  end

  it "should be able to Verify the user can able to edit the report::Tny1639337c & Tny1642644c" do

    on ScheduledReportsPage do |page|
      page.scheduleReport_edit
      sleep 2
      page.toaster_element.should be_present
      #      page.expect_toaster("Report Schedule updated successfully.")
    end
  end

  it "should be able Verify the user can able to suspend multiple scheduled reports::Tny1639340c" do

    on ScheduledReportsPage do |page|
      page.suspend_morereport
      expect_output=schedule_report_serv['report_suspended']
      expect(page.nextruntimeText_element.text).to be == expect_output
    end
  end

  it "should be able Verify the user can able to resume multiple scheduled reports::Tny1639341c" do

    on ScheduledReportsPage do |page|
      page.resume_morereport
      expect_output=schedule_report_serv['report_suspended']
      expect(page.nextruntimeText_element.text).not_to be == expect_output
    end
  end

  it "should be able Verify the user can able to delete the report::Tny1639338c" do

    on ScheduledReportsPage do |page|
      page.delete_report
      sleep 2
      #      page.expect_toaster('Report(s) Schedule deleted successfully:')
      expect_output=schedule_report_serv['report_delete']
      expect(page.noresults_element.text).to be == expect_output
    end
  end

  it "should be able Verify the user can able to delete multiple scheduled reports::Tny1639339c" do

    on ScheduledReportsPage do |page|
      page.delete_morereport
      sleep 2
      page.row1_element.should_not be_present
      #       page.expect_toaster("Report(s) Schedule deleted successfully:")
      #      expect_output=schedule_report_serv['report_delete']
      #      expect(page.noresults_element.text).to be == expect_output
    end
  end

  it "should be able Verify that flash.clicking the number of Schedules Count in Report Template page will redirect to Scheduled reports page::Tny1639343c" do

    on ScheduledReportsPage do |page|
      page.rediret_scheduleRepor
      sleep 3
      expect_output=schedule_report_serv['page_title']
      expect(page.pageTitle_element.text).to be == expect_output
    end

  end

  it "should be able Verify the Run History table is displaying for Run History in Scheduled Reports Page::Tny1642643c" do

    on ScheduledReportsPage do |page|
      page.run_history
      page.runtitle_element.should be_present
      #       expect="Detailed Analysis: Errors and Discards"
      #       page.errodiscards_interface_detailview.should include expect
    end
  end

end

describe "US6500 & US11182 -Schedule Report" do

  before :all do
    visit ScheduledReportsPage
  end

  it "should be able Verify the scheduled report should be listed in the Scheduled repots page::Tny1653160c" do
    on ScheduledReportsPage do |page|
      page.schedule_report_customView.should be_true
    end
  end

  it "should be able Verify the scheduled report quick filter option::Tny1835898c" do  ##Regression TestCase
    on ScheduledReportsPage do |page|
      page.schedule_report_quickfilter.should be_true
    end
  end

  it "should be able Verify the scheduled report show drop down::Tny1835900c" do   ##Regression TestCase
    on ScheduledReportsPage do |page|
      expect_output= ['Quick Filter','Advanced Filter','All','Manage Preset Filters','Yesterday','Last Week','Last Month','Last 3 Months','Suspended Reports','Schedule Ended Reports','Scheduled Reports']
      expect(page.schedule_report_show).to be == expect_output
    end
  end

  it "should be able Verify the scheduled report edit option::Tny1835901c" do    ##Regression TestCase
    on ScheduledReportsPage do |page|
      page.schedule_report_editoption.should be_true
    end
  end

  it "should be able Verify the scheduled report sort option::Tny1835899c" do   ##Regression TestCase
    on ScheduledReportsPage do |page|
      page.schedule_report_sortoption.should be_true
    end
  end

  it "should be able Verify the Schedule a report with repeats as only once::Tny1653161c" do
    on ScheduledReportsPage do |page|
      page.schedule_report_repeats
      #      sleep 2
      page.expect_toaster('Report Schedule updated successfully.')
      #      sleep 2
      #      page.toaster_element.should be_present
    end
  end

  it "should be able Verify the Run history count should be incremented::Tny1653164c" do
    on ScheduledReportsPage do |page|
      page.report_Run_Now.should be_true
    end
  end

  it "should be able Verify flash.click on Run now in a suspended report::Tny1653165c" do
    on ScheduledReportsPage do |page|
      page.report_Run_Now_Disable.should be_true
    end
  end

  it "should be able Verify Next run time should be updated as per the report created::Tny1653166c" do
    on ScheduledReportsPage do |page|
      page.report_next_runTime_update.should be_true
    end
  end

  it "should be able Verify Refresh button in scheduled reports page::Tny1653168c" do
    on ScheduledReportsPage do |page|
      page.refresh_element.flash
      page.refresh_element.when_present.flash.click
      page.refresh_element.should be_present
    end
  end

  it "should be able Verify Changing the columns of the Schedules reports page::Tny1653169c" do	 ##Regression TestCase Modified
    on ScheduledReportsPage do |page|
      page.schedule_Report_Setting.should be_true
    end
  end

  it "should be able verify the disk used by graph::Tny1653171c" do
    on ScheduledReportsPage do |page|
      page.schedule_Report_DiskUsed.should be_true
    end
  end

  it "should be able verify the Reports (with Attachment/Total) by graph::Tny1653172c" do
    on ScheduledReportsPage do |page|
      page.reports_update.should be_true
    end
  end

  it "should be able to Verify purging the reports::Tny1653173c" do
    on ScheduledReportsPage do |page|
      page.purging_report
      page.toaster_element.should be_present
      #      page.expect_toaster("Selected file(s) purged successfully.")

    end
  end

  it "should be able verify purging multiple records::Tny1653174c" do
    on ScheduledReportsPage do |page|
      page.purging_MultipleReport
      sleep 1
      page.toaster_element.should be_present
      #      page.expect_toaster('Selected file(s) purged successfully.')
    end
  end

  it "should be able Verify able to schedule reports from default dashboard::Tny1653178c" do
    on ScheduledReportsPage do |page|
      page.scheduleReport_Dashbord
      page.toaster_element.should be_present
      #      sleep 2
      #      page.expect_toaster('Report Schedule updated successfully.')
    end
  end

end