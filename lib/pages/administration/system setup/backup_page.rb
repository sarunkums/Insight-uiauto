class BackupPage < AppPage

  div(:backupBreadCrumb,:class=>"breadCrumbArea")

  div(:enabschdl,:class=>"fbField",:index=>1)
  div(:sshbcksrvr,:class=>"fbField",:index=>2)
  div(:path,:class=>"fbField",:index=>3)
  div(:port,:class=>"fbField",:index=>4)
  div(:uname,:class=>"fbField",:index=>5)
  div(:pwd,:class=>"fbField",:index=>6)
  div(:strttime,:class=>"fbField",:index=>7)

  div(:schdl,:class=>"dijitInline dijitCheckBox")
  checkbox(:chkschdl){schdl_element.checkbox(:class=>"dijitCheckBoxInput")}

  text_field(:bcksrvr_txtbox){sshbcksrvr_element.text_field(:class,"dijitInputInner")}
  text_field(:path_txtbox){path_element.text_field(:class,"dijitInputInner")}
  text_field(:port_txtbox){port_element.text_field(:class,"dijitInputInner")}
  text_field(:uname_txtbox){uname_element.text_field(:class,"dijitInputInner")}
  text_field(:pwd_txtbox){pwd_element.text_field(:class,"dijitInputInner")}
  text_field(:strttime_txtbox){strttime_element.text_field(:class,"dijitDownArrowButton")}

  div(:applyclear,:class=>"fbField",:index=>10)
  span(:apply_button){applyclear_element.span(:text=>"Apply")}
  span(:clear_button){applyclear_element.span(:text=>"Clear")}

  div(:tstconn,:class=>"fbField",:index=>11)
  span(:tstconn_button){tstconn_element.span(:text=>"Test Connection")}

  div(:title,:class=>"pageTitleLabel")
  
  div(:toaster,:class=>"xwtToasterMessageWrapper")
  div(:toastermsg){toaster_element.div(:class=>"xwtBody")}
  
  div(:popup,:class=>"xwtAlert")
  div(:popupMsg){popup_element.div(:class=>"dijitDialogPaneContent")}
  div(:popupOK){popup_element.span(:text=>"OK")}
   
  def loaded?(*how)
    title_element.present?
  end

  def goto
    navigate_application_to "Administration=>System Setup=>Backup"
  end

  def loaded?(*how)
    backupBreadCrumb_element.present?
  end

  def chk_bkupPage
    if ((enabschdl_element.exists?) && (bcksrvr_txtbox_element.exists?) && (path_txtbox_element.exists?) && (port_txtbox_element.exists?) && (uname_txtbox_element.exists?) && (pwd_txtbox_element.exists?) && (strttime_txtbox_element.exists?) && (apply_button_element.exists?) && (clear_button_element.exists?) && (tstconn_button_element.exists?))
      puts"Success"
      return true
    else
      puts "Failure"
      return false
    end
  end

  def schedule_disabled
    if self.chkschdl_element.checked?
      puts"Failure"
      return false
    else
      puts "Success"
      return true
    end
  end

  def enable_schedule
    if self.chkschdl_element.checked?
      puts "Schedule Enabled Already"
    else
      self.chkschdl_element.flash.click
      puts "Schedule Enabled"
    end
  end

  def Backup_validInputs
    sleep 3
    self.bcksrvr_txtbox_element.clear
    self.bcksrvr_txtbox_element.set $pc_server_ip
    self.path_txtbox_element.clear
    self.path_txtbox_element.set '/'
    self.port_txtbox_element.clear
    self.port_txtbox_element.set '22'
    self.uname_txtbox_element.clear
    self.uname_txtbox_element.set 'root'
    self.pwd_txtbox_element.clear
    self.pwd_txtbox_element.set $pc_pwd
    today=Time.now
    tomorrow=today+(60*60*24)
    date=tomorrow.strftime("%Y-%m-%d %H:%M")
    self.strttime_txtbox_element.clear
    self.strttime_txtbox_element.set date
  end

  def Backup_invalidInputs
    sleep 3
    self.bcksrvr_txtbox_element.clear
    self.bcksrvr_txtbox_element.set $pc_server_ip
    self.path_txtbox_element.clear
    self.path_txtbox_element.set '/'
    self.port_txtbox_element.clear
    self.port_txtbox_element.set '22'
    self.uname_txtbox_element.clear
    self.uname_txtbox_element.set 'root'
    self.pwd_txtbox_element.clear
    self.pwd_txtbox_element.set 'Abcd123$'
    today=Time.now
    tomorrow=today+(60*60*24)
    date=tomorrow.strftime("%Y-%m-%d %H:%M")
    self.strttime_txtbox_element.clear
    self.strttime_txtbox_element.set date
  end

  def test_connection
    self.tstconn_button_element.flash.click
    actual = self.toastermsg_element.text
    return actual
  end

  def apply
    self.apply_button_element.flash.click
    actual = self.toastermsg_element.text
    return actual
  end
  
  def warningmsg
    actual=self.popupMsg_element.text
    self.popupOK_element.click
    return actual
  end  
        
  def clear
    self.clear_button_element.flash.click
    if self.chkschdl_element.checked?
      puts"Failure"
      return false
    else
      puts "Success"
      return true
    end
  end

end
