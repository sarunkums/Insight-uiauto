class PISuserReport < InterfaceUtilizationPage

  @@creator="creator"
  @@viewer="viewer"
  @@pass="User@123"

  div(:ribben,:class=>"xwtRibbonWrapper")
  span(:addUser){ribben_element.span(:class=>"xwtContextualAddRow")}

  #Page object for add and update user details form
  div(:popup,:class=>"xwtDialog dijitDialog")
  text_field(:name,:id=>"username")
  text_field(:passwd,:id=>"password")
  text_field(:repasswd,:id=>"repassword")
  text_field(:fstname,:id=>"firstname")
  text_field(:lstname,:id=>"lastname")
  text_field(:email,:id=>"email")
  span(:buttonok){popup_element.span(:text=>"OK")}
  span(:buttoncancel){popup_element.span(:text=>"Cancel")}

  text_field(:titlereport){filterBox_element.div(:class=>"cell-2").text_field(:class=>"dijitInputInner")}
  div(:tabody,:class=>"table-body")
  div(:titleText){tabody_element.div(:class=>"row-0").div(:class=>"cell-2")}

  def goto
    navigate_application_to "Home"
  end

  def scheduleRport_FromChart(title)
    @browser.scroll.to :center
    @browser.div(:class=>"chartNode").wd.location_once_scrolled_into_view
    @browser.div(:class=>"bottomRegion").div(:class=>"bottomIcons").div(:title=>"Export/Print").when_present.flash.click
    sleep 2
    smallpop = @browser.div(:class,"dijitPopup Popup").id
    @browser.div(:id,"#{smallpop}").div(:text=>"Schedule Report").when_present.flash.click
    ind=0
    until @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").present?
      puts "interface_ScheduleReport: #{ind}"
      ind = ind + 1
    end
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").flash
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").text_field(:name=>"title").set(title)
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").span(:text=>"Save").when_present.flash.click
  end

  def reportTitleIn_scheduleReport(title)
    visit ScheduledReportsPage
    sleep 5
    self.titlereport_element.when_present(15).set(title)
    sleep 3
    actual=self.titleText_element.text
    if title == actual
      puts"Success-Scheduled report should be listed in the Scheduled repots page."
      return true
    else
      puts"Failure-Scheduled report should not be listed in the Scheduled repots page."
      return false
    end
  end

  def scheduleRport_FromInterfaceUtilQuickView(title)
    visit PISuserReport
    sleep 5
    @browser.div(:class=>"table-container").wd.location_once_scrolled_into_view
    @browser.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present(5).click
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    sleep 3
    @browser.div(:id,"#{popid}").div(:class=>"bottomIcons").div(:title=>"Export/Print").when_present.flash.click
    smallpop = @browser.div(:class,"dijitPopup Popup").id
    @browser.div(:id,"#{smallpop}").div(:text=>"Schedule Report").when_present.flash.click
    ind=0
    until @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").present?
      puts "interface_ScheduleReport: #{ind}"
      ind = ind + 1
    end
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").flash
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").text_field(:name=>"title").set(title)
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").span(:text=>"Save").when_present.flash.click
  end

  def scheduleRport_FromIntrfaceUtilDetailView(title)
    visit PISuserReport
    sleep 5
    @browser.div(:class=>"table-container").wd.location_once_scrolled_into_view
    @browser.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present(5).click
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    sleep 3
    @browser.div(:id,"#{popid}").div(:class=>"DetailLink").when_present.flash.click
    sleep 10
    @browser.scroll.to :bottom
    @browser.div(:class=>"bottomIcons").div(:title=>"Export").when_present.flash.click
    smallpop = @browser.div(:class,"dijitPopup Popup").id
    @browser.div(:id,"#{smallpop}").div(:text=>"Schedule Report").when_present.flash.click
    ind=0
    until @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").present?
      puts "interface_ScheduleReport: #{ind}"
      ind = ind + 1
    end
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").flash
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").text_field(:name=>"title").set(title)
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").span(:text=>"Save").when_present.flash.click
  end

  def scheduleRport_QuickView(title,new_tab,indQV)
    visit PISuserReport
    self.select_dashboard_tab(new_tab)
    @browser.div(:class=>"table-container").wd.location_once_scrolled_into_view
    errorParent.div(:class=>"table-container").div(:class=>"row-1").span(:class=>"xwtPopoverHintHoverIcon",:index=>indQV).when_present(5).click
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    sleep 3
    @browser.div(:id,"#{popid}").div(:class=>"bottomIcons").div(:title=>"Export/Print").when_present.flash.click
    smallpop = @browser.div(:class,"dijitPopup Popup").id
    @browser.div(:id,"#{smallpop}").div(:text=>"Schedule Report").when_present.flash.click
    ind=0
    until @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").present?
      puts "interface_ScheduleReport: #{ind}"
      ind = ind + 1
    end
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").flash
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").text_field(:name=>"title").set(title)
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").span(:text=>"Save").when_present.flash.click
  end

  def scheduleRport_DetailView(title,new_tab,indQV)
    visit PISuserReport
    self.select_dashboard_tab(new_tab)
    @browser.div(:class=>"table-container").wd.location_once_scrolled_into_view
    errorParent.div(:class=>"table-container").div(:class=>"row-1").span(:class=>"xwtPopoverHintHoverIcon",:index=>indQV).when_present(5).click
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    sleep 3
    @browser.div(:id,"#{popid}").div(:class=>"DetailLink").when_present.flash.click
    sleep 10
    @browser.scroll.to :bottom
    @browser.div(:class=>"bottomIcons").div(:title=>"Export").when_present.flash.click
    smallpop = @browser.div(:class,"dijitPopup Popup").id
    @browser.div(:id,"#{smallpop}").div(:text=>"Schedule Report").when_present.flash.click
    ind=0
    until @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").present?
      puts "interface_ScheduleReport: #{ind}"
      ind = ind + 1
    end
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").flash
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").text_field(:name=>"title").set(title)
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").span(:text=>"Save").when_present.flash.click
  end

  def accountCreation_reportCreatorViewer
    visit UsermanagementPage
    self.addUser_element.flash.click
    self.name_element.set(@@creator)
    self.passwd_element.set(@@pass)
    self.repasswd_element.set(@@pass)
    self.fstname_element.set"FirstTest"
    self.lstname_element.set"LastTest"
    self.email_element.set"Test@cisco.com"
    @browser.checkbox(:id,"creator").click
    if $browser_type == :ie10
      ind=0
      until @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").present?
        ind=ind+1
        puts"popup ID: #{ind}"
      end
      sleep 20
      @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").span(:text=>"OK",:index=>0).when_present.flash.click
    else
      self.buttonok_element.when_present(50).flash.click
    end
    sleep 5
    self.addUser_element.flash.click
    self.name_element.set(@@viewer)
    self.passwd_element.set(@@pass)
    self.repasswd_element.set(@@pass)
    self.fstname_element.set"FirstTest"
    self.lstname_element.set"LastTest"
    self.email_element.set"Test@cisco.com"
    if $browser_type == :ie10
      ind=0
      until @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").present?
        ind=ind+1
        puts"popup ID: #{ind}"
      end
      sleep 20
      @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").span(:text=>"OK",:index=>0).when_present.flash.click
    else
      self.buttonok_element.when_present(50).flash.click
    end

    sleep 5
    on LoginPage do |page|
      puts "comes here"
      page.logoutFromPC
      page.login_with(@@creator,@@pass)
      sleep 5
    end
    sleep 10
    self.evaluation_alert()
    sleep 2
    @browser.div(:class=>'xwtPopoverClose icon-close xwtPopoverButton').when_present.flash.click

  end

  def scheduleReport_ReportViewer
    sleep 5
    on LoginPage do |page|
      page.logoutFromPC
      page.login_with(@@viewer,@@pass)
      sleep 5
    end
    sleep 10
    self.evaluation_alert()
    sleep 2
    @browser.div(:class=>'xwtPopoverClose icon-close xwtPopoverButton').when_present.flash.click
    sleep 3
    @browser.div(:class=>"table-container").wd.location_once_scrolled_into_view
    @browser.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present(5).click
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    sleep 3
    @browser.div(:id,"#{popid}").div(:class=>"bottomIcons").div(:title=>"Export/Print").when_present.flash.click
    smallpop = @browser.div(:class,"dijitPopup Popup").id
    @browser.div(:id,"#{smallpop}").div(:text=>"Schedule Report").when_present.flash.click
    sleep 3
    actual=self.alertText_element.text
    return actual
  end

end
