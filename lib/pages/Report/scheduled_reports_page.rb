class ScheduledReportsPage < SavedReportPage

  @@updatetitle="update sample_dash1 @:#{Time.now}"
  div(:pageload, :id=>"globalBreadcrumb")
#  span(:titleSchedule,:class=>"xwtBreadcrumbText xwtBreadcrumbLast")
  #Page objects for Scheduled Reports Table header button

  span(:editBtn,:id=>"editBtn_label")
  span(:deleteBtn,:id=>"deleteBtn_label")
  span(:suspendBtn,:id=>"suspendBtn_label")
  span(:resumeBtn,:id=>"resumeBtn_label")
  span(:refresh,:id=>"analyticsScheduleReportTab_xwtTableGlobalToolbar_refreshButton")

  #Page object for filter text box

  div(:tableHeader,:class=>"table-header-container filter-by-example")
  div(:filterBox){tableHeader_element.div(:class=>"xwtFilterByExample")}

  text_field(:titlereport){filterBox_element.div(:class=>/cell-2/).text_field(:class=>/dijitInputInner/)}
  text_field(:scheduled){filterBox_element.div(:class=>/cell-4/).text_field(:class=>/dijitInputInner/)}

  #Page object for user table text

  div(:tabody,:class=>"table-body")
  div(:titleText){tabody_element.div(:class=>/row-0/).div(:class=>/cell-2/)}
  div(:scheduledText){tabody_element.div(:class=>/row-0/).div(:class=>/cell-4/)}
  div(:runstatusText){tabody_element.div(:class=>/row-0/).div(:class=>/cell-5/)}
  div(:nextruntimeText){tabody_element.div(:class=>/row-0/).div(:class=>/cell-7/)}
  div(:runhistoryText){tabody_element.div(:class=>/row-0/).div(:class=>/cell-8/)}
  div(:runhistoryLink){tabody_element.div(:class=>"row-0").div(:class=>"cell-8").a}
  div(:runnowText){tabody_element.div(:class=>/row-0/).div(:class=>/cell-9/)}
  link(:runnowLinkRow1){tabody_element.div(:class=>/row-0/).div(:class=>/cell-9/).a}
  link(:runnowLinkRow2){tabody_element.div(:class=>/row-1/).div(:class=>/cell-9/).a}
  div(:filtersettingText){tabody_element.div(:class=>/row-0/).div(:class=>/cell-9/)}

  #Page object for radio button

  checkbox(:row1){tabody_element.div(:class=>"row-0").div(:class=>"cell-0").input(:class=>"selection-input")}
  checkbox(:row2){tabody_element.div(:class=>"row-1").div(:class=>"cell-0").input(:class=>"selection-input")}

  #Page object for no-results

  div(:noresults,:class=>"no-results")

  #Page object for Run-History Dialog

  div(:rundialog,:class=>"xwtDialog dijitDialog")
  span(:runtitle){rundialog_element.span(:class=> "dijitDialogTitle")}
  #  span(:runrefresh){rundialog_element.span(:class=> "xwtGlobalRefresh")}
  span(:runrefresh){rundialog_element.div(:class=>"xwtGlobalToolbar").span(:class=> "xwtGlobalRefresh")}
  span(:purgeButton){rundialog_element.span(:text=>"Purge")}
  checkbox(:runselection1){rundialog_element.div(:class=>"row-0").div(:class=>"cell-0").input(:class=>"selection-input")}
  checkbox(:runselection2){rundialog_element.div(:class=>"row-1").div(:class=>"cell-0").input(:class=>"selection-input")}
  checkbox(:runselection3){rundialog_element.div(:class=>"row-2").div(:class=>"cell-0").input(:class=>"selection-input")}

  #  Page object for Toaster

  div(:toaster,:class=>"dijitToasterContainer dijitToasterMessage")

  def goto
    navigate_application_to "Report=>Scheduled Reports"
  end

  #  def loaded?(*how)
  #    pageload_element.present?
  #  end

  def delete_report

    begin
      self.titlereport_element.when_present(5).set(@@reporttitle)
      self.row1_element.when_present.flash.click
      self.deleteBtn_element.when_present.flash.click
      self.deletealertOK_element.when_present.flash.click
    rescue
      self.titlereport_element.when_present(5).set(@@updatetitle)
      self.row1_element.when_present.flash.click
      self.deleteBtn_element.when_present.flash.click
      self.deletealertOK_element.when_present.flash.click
    end
  end

  def suspend_report

    on SavedReportPage do |page|
      puts "comes here"
      page.viewname_element.when_present(5).clear
      page.discription_element.when_present(5).flash.click
      page.scheduleReport
    end

    visit ScheduledReportsPage
    self.titlereport_element.when_present(15).set(@@reporttitle)
    self.row1_element.when_present(5).flash.click
    self.suspendBtn_element.when_present.flash.click
  end

  def resume_report
    self.titlereport_element.when_present(5).clear
    self.titlereport_element.when_present(5).set(@@reporttitle)
    self.row1_element.when_present.focus
    self.row1_element.when_present(5).flash.click
    self.resumeBtn_element.when_present(5).flash.click
  end

  def scheduleReport_enddate       # Need to to check the failure case

    endate=Time.now.strftime("%m/%d/%y")
    self.row1_element.when_present(5).flash.click
    self.editBtn_element.when_present(5).flash.click
    sleep 10
    self.div_element(:class=>"xwtDialog").exists?
    sleep 5
#    @browser.div(:class=>"xwtDialog").span(:class=>"dijitDialogIcon dijitDialogCloseIcon icon-close").flash.click
    self.cancel_element.flash.click
    #    self.div_element(:class=>"dijitLayoutContainer xwtDialog dijitDialog").div(:class=>"dijitReset dijitRight dijitButtonNode dijitArrowButton dijitDownArrowButton dijitArrowButtonContainer icon-triangle icon-rotate-90").fire_event"onclick"
    #    @browser.td(:text=>"Monthly").when_present(3).flash.click
    #    self.endDateratio_element.when_present(5).focus
    #    self.endDateratio_element.when_present(5).flash.click
    #    self.enddate_element.when_present(3).flash.click
    #    self.enddateTextBox_element.when_present.set(endate)

  end

  def scheduleReport_edit

    if $browser_type == :ie10
      self.editBtn_element.when_present(15).flash.flash.click
    else
      self.editBtn_element.when_present(15).fire_event"onclick"
    end
    
    self.report_title_element.when_present(20).set("date #{@@updatetitle}")
    self.report_desc_element.when_present(5).set"updated description"
    self.report_emmail1_element.when_present(5).set"prime_insight1@cisco.com"
    self.report_emmail2_element.when_present(5).set"prime_insight1@cisco.com"
    @browser.div(:class=>"xwtDialog dijitDialog").span(:text=>"Save").flash.click
    #    self.save_element.when_present.flash.click
#    begin
#      self.alertYES_element.when_present.flash.click
#    rescue
#      puts"Email is already configured"
#    end
  end

  def suspend_morereport
    self.titlereport_element.when_present(15).clear
    self.scheduled_element.when_present(5).clear
    self.row1_element.when_present(5).flash.click
    self.row2_element.when_present(5).flash.click
    self.suspendBtn_element.when_present.flash.click
  end

  def resume_morereport
    self.row1_element.when_present(5).flash.click
    self.row2_element.when_present(5).flash.click
    self.resumeBtn_element.when_present.flash.click
  end

  def delete_morereport

    visit SavedReportPage
    sleep 3
    on SavedReportPage do |page|
      page.scheduleReport
    end
    visit ScheduledReportsPage
    sleep 3
    self.titlereport_element.when_present(5).clear
    self.scheduled_element.when_present(5).clear
    self.row1_element.when_present(5).flash.click
    self.row2_element.when_present(5).flash.click
    self.deleteBtn_element.when_present.flash.click
    self.deletealertOK_element.when_present.flash.click
  end

  def rediret_scheduleRepor

    visit SavedReportPage
    self.no_scheduleText_element.when_present.flash.click
  end

  def run_history

    visit SavedReportPage
    on SavedReportPage do |page|
      puts "comes here"
      page.viewname_element.when_present(5).clear
      page.discription_element.when_present(5).flash.click
      page.scheduleReport
    end
    visit ScheduledReportsPage
    sleep 3
    self.runnowLinkRow1_element.when_present(15).flash.click
    self.runnowLinkRow1_element.when_present(15).flash.click
    self.refresh_element.when_present.flash.click
    sleep 5
    self.runhistoryLink_element.when_present(3).focus
    self.runhistoryLink_element.when_present(5).flash.click
    sleep 5
    self.runrefresh_element.when_present(5).flash.click
    self.runrefresh_element.when_present(5).flash.click

  end

  def schedule_report_customView

    #    visit CustomViewsPage
    #    sleep 3
    #    on CustomViewsPage do |page|
    #      puts "comes here-CustomView"
    #      page.homeDashlet_Data
    #    end
    visit SavedReportPage
    sleep 5
    on SavedReportPage do |page|
      puts "comes here-SaveReport"
      page.scheduleReport_Data_saveReport
    end
    visit ScheduledReportsPage
    puts "comes here-ScheduledReportsPage"
    sleep 3
    dashletNames=["sample_dash1","sample_dash2"]
    actual=[]
    dashletNames.each do |dashletName|
      self.titlereport_element.when_present(15).clear
      self.titlereport_element.when_present(15).set(dashletName)
      sleep 3
      actual<<self.titleText_element.text
    end
    if dashletNames == actual
      puts"Success-Scheduled report should be listed in the Scheduled repots page."
      return true
    else
      puts"Failure-Scheduled report should not be listed in the Scheduled repots page."
      return true
    end
  end

  def schedule_report_quickfilter
    self.titlereport_element.when_present(15).clear
    self.titlereport_element.when_present(15).set("sample_dash1")
    actual=self.titleText_element.text
    if actual == 'sample_dash1'
      puts "Success-Schedule report quick filter working properly"
      return true
    else
      puts "Failure-Schedule report quick filter not working properly"
      return false
    end
  end
  
  def schedule_report_show
    @browser.div(:class=>"xwtQuickFilter").div(:class=>"dijitDownArrowButton").click
    actual=[]
    for i in 0..10
      p=browser.table(:class=>"xwtTableQuickFilterMenu").td(:class=>"dijitMenuItemLabel",:index=>i).text
      actual<<p
    end
    return actual
  end
  
def schedule_report_editoption

    self.titlereport_element.when_present(15).clear
    self.titlereport_element.when_present(15).set("sample_dash1")
    self.row1_element.when_present(5).flash.click
    sleep 5
      if $browser_type == :ie10
        self.editBtn_element.when_present(5).flash.flash.click
      else
        self.editBtn_element.when_present(5).fire_event"onclick"
      end
      sleep 8
      self.report_desc_element.when_present.clear
      self.report_desc_element.when_present.set"edited description"
      self.save_element.when_present.flash.click
  end
  
  def schedule_report_sortoption
    sleep 3
        uiall = []
        uiall = @browser.div(:class=>"table dijitLayoutContainer dijitContainer").div(:class,"table-container").divs(:class,/row/)
        unsorted = []
        uiall.each do |p|
          p.table(:class,"row-table").tr.td(:class => /cell-container/, :index =>2).flash
          unsorted << p.table(:class,"row-table").tr.td(:class => /cell-container/, :index =>2).text.scan(/[A-Z#]+/i)
        end
        ascendingsort  = unsorted.sort {|x, y| x <=> y}
        puts "Ascending", ascendingsort
        descendingsort = unsorted.sort! {|x, y| y <=> x}
        puts "Descending", descendingsort
       
        browser.div(:class=>"table dijitLayoutContainer dijitContainer").div(:class,"table-head-node-container").table(:class,"table-header").td(:class => /cell-container-2/).when_present.click
        uiall = @browser.div(:class=>"table dijitLayoutContainer dijitContainer").div(:class,"table-container").divs(:class,/row/)
        sorted = []
        uiall.each do |p|
          p.table(:class,"row-table").tr.td(:class => /cell-container/, :index =>2).flash
          sorted << p.table(:class,"row-table").tr.td(:class => /cell-container/, :index =>2).text.scan(/[A-Z#]+/i)
        end
    
        if sorted == ascendingsort
          puts "It sorted successfully in ascending"
        else
          if sorted ==  descendingsort
            puts "It sorted successfully in descending"
          else
            puts "There is some problem in sorting"
            return false
          end
        end
        browser.div(:class=>"table dijitLayoutContainer dijitContainer").div(:class,"table-head-node-container").table(:class,"table-header").td(:class => /cell-container-2/).when_present.click
        uiall = @browser.div(:class=>"table dijitLayoutContainer dijitContainer").div(:class,"table-container").divs(:class,/row/)
        sorted = []
        uiall.each do |p|
          p.table(:class,"row-table").tr.td(:class => /cell-container/, :index =>2).flash
          sorted << p.table(:class,"row-table").tr.td(:class => /cell-container/, :index =>2).text.scan(/[A-Z#]+/i)
        end
        if sorted == ascendingsort
          puts "It sorted successfully in ascending"
          return true
        else
          if sorted ==  descendingsort
            puts "It sorted successfully in descending"
            return true
          else
            puts "There is some problem in sorting"
            return false
          end
    end
  end

  def schedule_report_repeats   # Here i did the schedule report repeate only- "Only Once"
    self.titlereport_element.when_present(15).clear
    self.titlereport_element.when_present(10).set("sample_dash1")
    self.row1_element.when_present(5).flash.click
    sleep 5
    if $browser_type == :ie10
      sleep 5
      self.editBtn_element.when_present.flash.click
    else
      self.editBtn_element.when_present(5).fire_event"onclick"
    end
    sleep 8
    @browser.div(:class=>"dijitDialogPaneContent dijitAlignCenter").div(:class=>"icon-triangle icon-rotate-90").when_present(5).flash.click
    #    @browser.element(:text,"Only Once").when_present.flash.click
    sleep 3
    self.report_title_element.set("sample_dash1_repeat@ #{Time.now}")
    self.save_element.when_present.flash.click
#    begin
#      self.alertYES_element.when_present.flash.click
#    rescue
#      puts"Email is already configured"
#    end

  end

  def report_Run_Now
    self.titlereport_element.when_present(5).clear
    self.row1_element.when_present(5).flash.click
    beforerun=self.runhistoryLink_element.text
    puts "before run: #{beforerun}"
    self.runnowLinkRow1_element.when_present.flash.click
    self.runnowLinkRow1_element.when_present.flash.click
    self.refresh_element.when_present.flash.click
    sleep 5
    self.runhistoryLink_element.focus
    afterrun=self.runhistoryLink_element.text
    puts "after run: #{afterrun}"
    if beforerun != afterrun
      puts "Success-The run history count is increased"
      return true
    else
      puts "Failure-The run history count is not increased"
      return false
    end
  end

  def report_Run_Now_Disable
    self.titlereport_element.when_present(5).clear
    self.titlereport_element.when_present(5).set("sample_dash2")
    self.row1_element.when_present(5).flash.click
    self.suspendBtn_element.when_present.flash.click
    if self.runnowLinkRow1_element.present?
      puts "Success-The run now button is enable"
      return true
    else
      puts "Failure-The run now button is disable"
      return false
    end

  end

  def report_next_runTime_update
    #        self.titlereport_element.when_present(5).set("sample_dash2")
    self.row1_element.when_present(7).flash.click
    self.resumeBtn_element.when_present(8).flash.click
    beforUpdate=self.nextruntimeText_element.text
    puts "before Update: #{beforUpdate}"
    self.row1_element.when_present(7).flash.click
    if $browser_type == :ie10
      self.editBtn_element.when_present(8).flash.flash.click
    else
      self.editBtn_element.when_present(8).fire_event"onclick"
    end
    sleep 10
    @browser.div(:class=>"dijitDialogPaneContent dijitAlignCenter").div(:class=>"icon-triangle icon-rotate-90").when_present(5).flash.click
    @browser.element(:text,"Weekly").when_present.flash.click
    sleep 5
    ind = 0
    until @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").present?
      puts ind
      ind = ind + 1
    end
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").tr(:index=>6).text_field(:index=>0).clear
    today=Time.now
    tomorrow=today+(60*60*24)
    date=tomorrow.strftime("%m/%d/%Y")
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").tr(:index=>6).text_field(:index=>0).set(date)
    sleep 3
    self.report_title_element.set("sample_dash2_repeat@ #{Time.now}")
    self.save_element.when_present.flash.click
#    begin
#      self.alertYES_element.when_present.flash.click
#    rescue
#      puts"Email is already configured"
#    end
    afterUpdate=self.nextruntimeText_element.text
    puts "after Update: #{afterUpdate}"
    if beforUpdate != afterUpdate
      puts "Success-The Next Run Time is Updated"
      return true
    else
      puts "Failure-The Next Run Time is Not Updated"
      return false
    end
  end

  def schedule_Report_Setting
    @browser.div(:class=>"xwtGlobalToolbarActions").span(:class=>"dijitReset dijitStretch dijitButtonContents dijitDownArrowButton").when_present.flash.click
    @browser.td(:id=>"analyticsScheduleReportTab_xwtTableGlobalToolbar_columnsMenu_text").when_present.flash.click
    @browser.div(:class=>"columnsContainerDiv").flash
    if @browser.div(:class=>"columnsContainerDiv").exists?
      puts "Success-The column can able add and remove"
      return true
    else
      puts "Failure-The column should not able add and remove"
      return false
    end
  end

  def schedule_Report_DiskUsed

    @browser.span(:id,"analyticsScheduleReportTab_xwtTableGlobalToolbar_columnsMenu_close_label").when_present.flash.click
    self.titlereport_element.when_present(5).clear
    self.scheduled_element.when_present(5).flash.click
    before_disk_used=@browser.div(:class=>"metricChartMainNode",:index=>1).div(:class=>"dashboardMetricItemValue").text
    puts "before Run1: #{before_disk_used}"
    @beforeReport=@browser.div(:class=>"metricChartMainNode",:index=>2).div(:class=>"dashboardMetricItemValue").text
    puts "before Run2: #{@beforeReport}"
    self.titlereport_element.when_present(10).set("sample_dash1")
    self.runnowLinkRow1_element.when_present.flash.click
    self.runnowLinkRow1_element.when_present.flash.click
    self.runnowLinkRow1_element.when_present.flash.click
    self.runnowLinkRow1_element.when_present.flash.click
    self.refresh_element.when_present.flash.click
    @browser.div(:class=>"metricChartMainNode",:index=>1).div(:class=>"dashboardMetricItemValue").flash
    after_disk_used=@browser.div(:class=>"metricChartMainNode",:index=>1).div(:class=>"dashboardMetricItemValue").text
    puts "after Run1: #{after_disk_used}"

    if before_disk_used != after_disk_used
      puts "Success-Schedule Report Disk Used is Updated"
      return true
    else
      puts "Failure-Schedule Report Disk Used is Not Updated"
      return false
    end
  end

  def reports_update

    puts "before Run: #{@beforeReport}"
    @browser.div(:class=>"metricChartMainNode",:index=>2).div(:class=>"dashboardMetricItemValue").flash
    after_disk_used=@browser.div(:class=>"metricChartMainNode",:index=>2).div(:class=>"dashboardMetricItemValue").text
    puts "after Run2: #{after_disk_used}"
    if @beforeReport != after_disk_used
      puts "Success-Schedule Reports count is Updated"
      return true
    else
      puts "Failure-Schedule Reports count is Not Updated"
      return false
    end
  end

  def purging_report
    self.titlereport_element.when_present(5).clear
    self.titlereport_element.when_present(10).set("sample_dash1")
    self.runhistoryLink_element.when_present(5).flash.click
    sleep 5
    self.runselection1_element.when_present.flash.click
    self.purgeButton_element.flash
    self.purgeButton_element.when_present.flash.click
    ind = 0
    until @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").present?
      puts ind
      ind = ind + 1
    end
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").span(:title=>"Cancel").flash.click

  end

  def purging_MultipleReport
    self.runhistoryLink_element.when_present(5).flash.click
    sleep 5
    ind = 0
    until @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").present?
      puts ind
      ind = ind + 1
    end
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").div(:class=>"row-1").div(:class=>"cell-0").input(:class=>"selection-input").flash.click
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").div(:class=>"row-2").div(:class=>"cell-0").input(:class=>"selection-input").flash.click
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").span(:text=>"Purge").flash
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").span(:text=>"Purge").flash.click
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").span(:title=>"Cancel").flash.click
  end

  def scheduleReport_Dashbord
    visit InterfaceUtilizationPage
    sleep 3
    on InterfaceUtilizationPage do |page|
      puts "comes here-InterfaceUtilizationPage"
      page.interface_ScheduleReport
    end
  end
end
