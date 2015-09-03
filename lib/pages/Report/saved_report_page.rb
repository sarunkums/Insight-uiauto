class SavedReportPage < AppPage

  @@reporttitle="sample_dash1 @:#{Time.now}"
  @@reporttitleNew="sample_dash2 @:#{Time.now}"

  div(:thetable, :id=>'theTable')
  div(:saveheader, :class=>'headerNode')
  span(:schedule, :class=>'dijitButtonNode', :text=>/Schedule/)

  #Page object for filter text box
  div(:tableHeader){div_element(:class=>"table-header-container filter-by-example").table(:class=>"table-header",:index=>1)}
  table(:tablefilterBox){table(:class=>"table-header",:index=>1)}

  text_field(:viewname){tableHeader_element.div(:class=>"cell-1").text_field(:class=>"dijitReset dijitInputInner")}
  text_field(:discription){tableHeader_element.div(:class=>"cell-2").text_field(:class=>"dijitReset dijitInputInner")}
  text_field(:scheduled){tableHeader_element.div(:class=>"cell-3").text_field(:class=>"dijitInputInner")}
  text_field(:no_schedule){tableHeader_element.div(:class=>"cell-4").text_field(:class=>"dijitInputInner")}

  #Page object for user table text
  div(:tabody,:class=>"table-body")
  div(:viewnameText){tabody_element.div(:class=>/row-0/).div(:class=>/cell-1/)}
  div(:discriptionText){tabody_element.div(:class=>/row-0/).div(:class=>/cell-2/)}
  div(:scheduledText){tabody_element.div(:class=>/row-0/).div(:class=>/cell-3/)}
  link(:no_scheduleText){tabody_element.div(:class=>/row-0/).div(:class=>/cell-4/).a}

  #Page object for radio button
  radio(:radio_row1){tabody_element.div(:class=>/row-0/).div(:class=>/cell-0/).input(:class=>"selection-input")}
  radio(:radio_row2){tabody_element.div(:class=>/row-1/).div(:class=>/cell-0/).input(:class=>"selection-input")}

  #Page objects for schedule reports pop up

   div(:popup,:class=>"xwtDialog dijitDialog")
#  div(:popup,:class=>"xwtDialog")
  text_field(:report_title,:name=>"title")
  text_field(:report_desc,:name=>"desc")
  text_field(:report_emmail1,:name=>"to_editor")
  text_field(:report_emmail2,:name=>"failed_to_editor")

  radio(:csv,:id=>"csvRadio")
  radio(:pdf,:id=>"pdfRadio")
  div(:startdate){popup_element.div(:class=>"calendarIcon",:index=>0)}
  div(:enddate){popup_element.div(:class=>"calendarIcon",:index=>1)}
  text_field(:enddateTextBox,:id=>/XwtDateTextBox/,:index=>1)
  radio(:endDateratio,:id=>/endDateRadio/)
  table(:calendarbody,:class=>/dijitCalendarContainer/)

  span(:save){popup_element.span(:text=>"Save")}
  span(:cancel){popup_element.span(:text=>"Cancel")}

  div(:titlealert,:class=>"dijitDialog defaultButton xwtAlert")
  div(:titlealerttext,:class=>"xwtAlert-warning")
  span(:titlealertok){titlealert_element.span(:text=>"OK",:index=>0)}

  def goto
    navigate_application_to "Report=>Saved Reports"
  end

  def loaded?(*how)
    saveheader_element.present?
  end

  def report_csv

    if csv_element.present?
      return true
    else
      return false
    end
  end

  def report_pdf

    if pdf_element.present?
      return true
    else
      return false
    end
  end

  def scheduleReport

    self.viewname_element.when_present(5).set"sample_dash1"
    sleep 3
    if $browser_type == :ie10
      self.radio_row1_element.flash.click
    else
      self.radio_row1_element.fire_event"onclick"
    end
    self.schedule_element.when_present.flash.click
    self.report_title_element.when_present(5).set(@@reporttitle)
    self.report_desc_element.when_present(5).set"verify description"
    self.report_emmail1_element.when_present(5).set"prime_insight1@cisco.com"
    self.report_emmail2_element.when_present(5).set"prime_insight1@cisco.com"
    self.save_element.when_present.flash.click
    #    self.alertYES_element.when_present.flash.click

  end

  def scheduleReport_count

    self.scheduleReport
    before_delete=self.no_scheduleText_element.text
    puts "before_delete: #{before_delete}"
    visit ScheduledReportsPage
    on ScheduledReportsPage do |page|
      puts "comes here"
      page.delete_report
    end

    visit SavedReportPage
    self.viewname_element.when_present(5).set"sample_dash1"
    self.radio_row1_element.when_present(5).flash.click
    after_delete=self.no_scheduleText_element.text
    puts "after_delete: #{after_delete}"
    sleep 3
    if after_delete != before_delete
      return true
    else
      return false
    end
  end

  def reportquick_filter
    self.viewname_element.when_present(5).set("sample_dash3")
    self.scheduled_element.when_present.set("Not Scheduled")
    sleep 5
    if self.viewnameText_element.text == "sample_dash3"
      return true
    else if self.scheduledText_element.text == "Not Scheduled"
        return true
      else
      end
    end
  end

  def scheduleReport_Toster
    sleep 5
    self.viewname_element.when_present.clear
    self.scheduled_element.when_present.clear
    self.viewname_element.when_present(5).set"sample_dash2"
    sleep 5
    if $browser_type == :ie10
      self.radio_row1_element.flash.click
    else
      self.radio_row1_element.fire_event"onclick"
    end
    self.schedule_element.when_present.flash.click
    self.report_title_element.when_present.set(@@reporttitleNew)
    self.report_desc_element.when_present(5).set"verify description"
    self.report_emmail1_element.when_present(5).set"prime_insight1@cisco.com"
    self.report_emmail2_element.when_present(5).set"prime_insight1@cisco.com"
    self.save_element.when_present.flash.click
    #    self.alertYES_element.when_present.flash.click
  end


  def scheduleReport_Data_saveReport

    dashletName=["sample_dash1","sample_dash2"]
    dashletName.each do |a|
      puts "dashname: #{a}"
      sleep 5
      self.viewname_element.when_present(5).clear
      self.discription_element.when_present(5).clear
      self.viewname_element.when_present(5).set(a)
      if $browser_type == :ie10
        self.radio_row1_element.flash.click
      else
        self.radio_row1_element.fire_event"onclick"
      end
      sleep 3
      if $browser_type == :ie10
        self.schedule_element.flash.click
      else
        self.schedule_element.fire_event"onclick"
      end
      sleep 10
      self.report_desc_element.when_present.set"verify description"
      self.report_emmail1_element.when_present.set"prime_insight1@cisco.com"
      self.report_emmail2_element.when_present.set"prime_insight1@cisco.com"
      self.save_element.when_present.flash.click
      #      begin
      #        self.alertYES_element.when_present.flash.click
      #      rescue
      #        puts"Email is already configured"
      #      end
    end

  end
end