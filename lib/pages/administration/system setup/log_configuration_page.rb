class LogConfigurationPage < AppPage

  div(:logconfigBreadCrumb,:class=>"breadCrumbArea")
  span(:titlepage,:class=>"xwtBreadcrumbLast")

  div(:module,:class=>"table-container")
  div(:modrow){module_element.div(:class=>"row noSel")}
  div(:moduletitle){modrow_element.div(:class=>"cell-2")}
  div(:logtitle){modrow_element.div(:class=>"cell-3")}
  div(:logrow,:class=>"row-editor")
  div(:logrowdrpdwn){logrow_element.div(:class=>"dijitArrowButton")}

  div(:radio1,:class=>"dijitRadio")
  radio(:enable_radio){radio1_element.radio(:class=>"selection-input")}
  
  span(:edit_button,:title=>"Edit")
  span(:reset_button,:text=>"Reset to Default")

  div(:actbutton,:class=>"rowActions")
  link(:save_button){actbutton_element.link(:text=>"Save")}
  link(:cancel_button){actbutton_element.link(:text=>"Cancel")}

  def goto
    navigate_application_to "Administration=>System Setup=>Log Configuration"
  end

  def loaded?(*how)
    logconfigBreadCrumb_element.present?
  end

  def page_title
    self.titlepage_element.text
  end

  def module_title
    self.moduletitle_element.text
  end

  def default_loglevel
    self.logtitle_element.text
  end

  def log_levels
    self.logtitle_element.click
    self.logrowdrpdwn_element.flash.click
    actual=[]
    for i in 0..4
      p=@browser.div(:class=>"dijitPopup dijitMenuPopup").tr(:class=>"dijitMenuItem",:index=>i).td(:class=>"dijitMenuItemLabel").text
      actual << p
    end
    return actual
  end

  def edit_loglevel
    self.enable_radio_element.flash.click
    self.edit_button_element.flash.click
    @browser.div(:class=>"xwtDropDown xwtComboBox dijitComboBox dijitSelect").present?
    return true
  end

  def save_loglevel
    self.reset_button_element.flash.click
    self.logtitle_element.click
    self.logrowdrpdwn_element.flash.click
    @browser.div(:class=>"dijitPopup dijitMenuPopup").tr(:class=>"dijitMenuItem",:index=>3).td(:class=>"dijitMenuItemLabel").click
    sleep 3
    self.save_button_element.flash.click
    sleep 3
    actual=self.logtitle_element.text
    return actual
  end

  def cancel_loglevel
    self.logtitle_element.click
    self.logrowdrpdwn_element.flash.click
    @browser.div(:class=>"dijitPopup dijitMenuPopup").tr(:class=>"dijitMenuItem",:index=>1).td(:class=>"dijitMenuItemLabel").click
    sleep 3
    self.cancel_button_element.flash.click
    sleep 3
    actual=self.logtitle_element.text
    return actual
  end

  def reset_loglevel
    self.reset_button_element.flash.click
    sleep 3
    actual=self.logtitle_element.text
    return actual
  end

end