class EmailSettingsPage < AppPage

  div(:emailBreadCrumb,:class=>"breadCrumbArea")

  div(:smtpfield,:class=>"fbField",:index=>0)
  div(:emailfield,:class=>"fbField",:index=>1)
  text_field(:smtp_txtbox){smtpfield_element.text_field(:id,"smtp_server")}
  text_field(:email_txtbox){emailfield_element.text_field(:id,"email_address")}

  div(:pagebuttons,:class=>"xwtFormActionContainer")
  span(:save_button){pagebuttons_element.span(:text=>"Save")}
  span(:reset_button){pagebuttons_element.span(:text=>"Reset")}
  span(:delete_button){pagebuttons_element.span(:text=>"Delete")}

  #Page object for alert box
  div(:alert_popup,:class=>"dijitDialog xwtAlert")
  span(:alert_okbutton){alert_popup_element.span(:text=>"OK")}
  div(:alert1_popup,:class=>"xwtAlert")
  span(:alert1_okbutton){alert1_popup_element.span(:text=>"OK")}

  div(:successtoaster,:class=>"xwt-success-message")

  def goto
    navigate_application_to "Administration=>System Setup=>Email Settings"
  end

  def loaded?(*how)
    emailBreadCrumb_element.present?
  end

  def chk_page
    if ((smtp_txtbox_element.exists?) && (email_txtbox_element.exists?) && (save_button_element.exists?) && (reset_button_element.exists?) && (delete_button_element.exists?))
      puts"Success"
      return true
    else
      puts "Failure"
      return false
    end
  end

  def chk_save
    self.smtp_txtbox_element.clear
    self.save_button_element.click
    self.alert1_okbutton_element.click
    self.smtp_txtbox_element.set "72.163.197.20"
    self.email_txtbox_element.set "noreply@domain.com"
    self.save_button_element.click
    self.successtoaster_element.present?
    return true
  end

  def chk_reset
    before=self.smtp_txtbox_element.text
    self.smtp_txtbox_element.clear
    self.email_txtbox_element.clear
    self.reset_button_element.click
    after=self.smtp_txtbox_element.text
    if before == after
      return true
    else
      return false
    end
  end

  def chk_delete
    self.delete_button_element.click
    self.alert_okbutton_element.click
    self.successtoaster_element.present?
    return true
  end

  def chk_default
    self.delete_button_element.click
    self.alert_okbutton_element.click
    opt1=self.smtp_txtbox_element.value
    self.email_txtbox_element.value
    opt2=self.email_txtbox_element.value
    if ((opt1 == " ") && (opt2 == "noreply@domain.com"))
      return true
    else
      return false
    end
  end

  def chk_schedule_report
    self.delete_button_element.click
    self.alert_okbutton_element.click
    visit InterfaceUtilization
    on InterfaceUtilization do |page|
      @browser.div(:class=>"bottomIcons").div(:title=>"Export/Print").when_present(3).click
      smallpop = @browser.div(:class,"dijitPopup Popup").id
      @browser.div(:id,"#{smallpop}").div(:class=>"dijitInline itemLabel",:text=>"Schedule Report").when_present(20).flash.click
      page.schedule_report
      self.alertYES_element.click
    end
    return true
  end

end