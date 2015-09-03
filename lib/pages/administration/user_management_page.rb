class UsermanagementPage < AppPage

  @@viewer="prime_viewer"
  @@viewer_pass="Viewerprime@123"

  @@creator="Prime@123"
  @@admin="prime_admin"

  @@updatedfirstname="Updated FirstTest"
  @@updatedlastname="Updated LastTest"
  @@updatedemail="UpdatedTest@cisco.com"

#  span(:titlepage,:class=>"xwtBreadcrumbText xwtBreadcrumbLast")
  div(:thetable, :id=>'theTable')
  div(:closeGettingStarted, :id => 'xwt_widget_layout_Popover_0_closeButton')
  div(:toggleIcon,:class=>"toggleIcon icon-cisco-menu")

  #Page object for add/edit/delete button
  div(:ribben,:class=>"xwtRibbonWrapper")
  span(:addUser){ribben_element.span(:class=>"xwtContextualAddRow")}
  span(:editUser){ribben_element.span(:class=>"xwtContextualEdit")}
  span(:deleteUser){ribben_element.span(:class=>"dijitReset dijitInline dijitIcon xwtContextualIcon xwtContextualDelete")}

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

  #Page object for column add and reset

  div(:tootlbaraction,:class=>"xwtGlobalToolbarActions")
  span(:setting){tootlbaraction_element.span(:class=>"dijitReset dijitStretch dijitButtonContents dijitDownArrowButton")}
  div(:dijitPopup,:class=>"dijitPopup dijitMenuPopup")
  td(:colum){dijitPopup_element.td(:class=>"dijitReset dijitMenuItemLabel")}
  div(:containerDiv,:class=>"columnsContainerDiv")
  td(:columRole){containerDiv_element.td(:text=>"Roles")}
  td(:columEmail){containerDiv_element.td(:text=>"Email")}
  td(:menuFooter,:class=>"xwtTableColumnsMenuFooter")
  span(:reset){menuFooter_element.span(:text=>"Reset")}
  table(:tablecolumHeader,:class=>"table-header")
  div(:tableRoles){tablecolumHeader_element.div(:text=>"Roles")}

  span(:rowcount){tootlbaraction_element.span(:class=>"selectionCountLabel")}

  #Page object for filter drop down
  div(:filterhead,:class=>"xwtQuickFilter")
  div(:filter){filterhead_element.div(:text=>"Quick Filter")}
  div(:filterpopup,:class=>"dijitPopup dijitMenuPopup")
  div(:filterAll){filterpopup_element.div(:text=>"All")}
  div(:filterQuick){filterpopup_element.div(:text=>"Quick Filter")}
  div(:tableHeader,:class=>"table-header-container filter-by-example")
  div(:filterBox){tableHeader_element.div(:class=>"xwtFilterByExample")}

  #Page object for filter text box
  text_field(:filterUsername){filterBox_element.div(:class=>"cell-1").text_field(:class=>"dijitInputInner")}
  text_field(:filterFirstname){filterBox_element.div(:class=>"cell-2").text_field(:class=>"dijitInputInner")}
  text_field(:filterLastname){filterBox_element.div(:class=>"cell-3").text_field(:class=>"dijitInputInner")}
  text_field(:filterEmail){filterBox_element.div(:class=>"cell-4").text_field(:class=>"dijitInputInner")}
  text_field(:filterRole){filterBox_element.div(:class=>"cell-5").text_field(:class=>"dijitInputInner")}
  #Page object for user table text
  div(:tabody,:class=>"table-container")
  div(:usernameText){tabody_element.div(:class=>"row-0").div(:class=>"cell-1")}
  div(:firstnameText){tabody_element.div(:class=>"row-0").div(:class=>"cell-2")}
  div(:lastnameText){tabody_element.div(:class=>"row-0").div(:class=>"cell-3")}
  div(:emailText){tabody_element.div(:class=>"row-0").div(:class=>"cell-4")}
  div(:roleText){tabody_element.div(:class=>"row-0").div(:class=>"cell-5")}
  #Page object for check box
  text_field(:checkbox_row1){tabody_element.div(:class=>"row-0").div(:class=>"cell-0").input(:class=>"selection-input")}
  text_field(:checkbox_row2){tabody_element.div(:class=>"row-1").div(:class=>"cell-0").input(:class=>"selection-input")}

  #Page object for alert box
  div(:alert_popup,:class=>"dijitDialog xwtAlert")
  span(:alert_okbutton){alert_popup_element.span(:text=>"OK")}
  span(:alert_cancelbutton){alert_popup_element.span(:text=>"Cancel")}

  ##Page object for Tooltip
  #span(:unamehelpicon,:id,"UserHelpIcon")
  #span(:pwdhelpicon,:id,"PassHelpIcon")
  div(:tooltip,:class=>"dijitTooltipRight")
  div(:tooltipvalue){tooltip_element.div(:class=>"dijitTooltipContents")}

  def goto
    navigate_application_to "Administration=>User Management"
  end
=begin
  def loaded?(*how)

    pageTitle_element.present?

  end
=end
  def page_title

    #    expect="User Management"
    #    actual=self.title_element.text
    self.pageTitle_element.text
    #    if expect==actual
    #      puts"Success-User management page is loaded"
    #      return true
    #    else
    #      puts"Failure-User management page is not loaded"
    #      return false
    #    end
    #
  end

  def add_user

    self.addUser_element.flash.click
    self.name_element.set(@@viewer)
    self.passwd_element.set(@@viewer_pass)
    self.repasswd_element.set(@@viewer_pass)
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
    
    self.filterUsername_element.when_present.set(@@viewer)
    sleep 2
    actual=self.usernameText_element.text
    if  @@viewer == actual
      puts"Success-User added successfully"
      return true
    else
      puts "Failure-User is not added"
      return false
    end
  end

  def updated_user
    puts"get into updated_user"
    updatedfirsname="Updated FirstTest"
    updatedlastname="Updated LastTest"
    updatedemail="UpdatedTest@cisco.com"
    sleep 3
    self.checkbox_row1_element.when_present(5).flash.click
    self.editUser_element.when_present(3).flash.click
    sleep 3
    self.fstname_element.set(updatedfirsname)
    self.lstname_element.set(updatedlastname)
    self.email_element.set(updatedemail)

    if $browser_type == :ie10
      ind=0
      until @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").present?
        ind=ind+1
        puts"popup ID: #{ind}"
      end
      @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").span(:text=>"OK",:index=>0).when_present.flash.click
    else
      self.buttonok_element.when_present(20).flash.click
    end

    self.filterUsername_element.when_present.set(@@viewer)
    self.filterFirstname_element.when_present.set(updatedfirsname)
    sleep 2
    actual=self.firstnameText_element.text
    if updatedfirsname == actual
      puts"Success-User updated successfully"
      return true
    else
      puts "Failure-User is not updated"
      return false
    end

  end

  def quick_filter

    updatedfirsname="Updated FirstTest"
    updatedlastname="Updated LastTest"
    updatedemail="UpdatedTest@cisco.com"
    self.filterUsername_element.when_present.clear
    self.filterFirstname_element.when_present.clear
    self.filterUsername_element.when_present.set(@@viewer)
    self.filterFirstname_element.when_present.set(updatedfirsname)
    sleep 2
    username=self.usernameText_element.text
    firstname=self.firstnameText_element.text
    if   @@viewer == username
      return true
    else
      if updatedfirsname == firstname
        puts "Success-Quick filter functionality is working"
        return true
      else
        puts "Failure-Quick filter functionality is not working"
        return false
      end
    end
  end

  def delete_user

    self.filterUsername_element.when_present.set(@@viewer)
    self.checkbox_row1_element.when_present(5).flash.click
    if  $browser_type == :ie10
      sleep 20
      self.deleteUser_element.when_present.flash.click
    else
      self.deleteUser_element.when_present(10).fire_event "onclick"
    end
    sleep 10
    self.deletealertOK_element.when_present.flash.click
    self.filterUsername_element.when_present.clear
    self.filterFirstname_element.when_present.clear
    self.filterUsername_element.when_present.set(@@viewer)
    self.filterFirstname_element.when_present.clear
    sleep 5
    if self.usernameText_element.exists?
      puts "Failure-User is not deleted"
      return false
    else
      puts"Success-User deleted successfully"
      return true
    end

  end

  def all_filter
    sleep 2
    self.filter_element.when_present.flash.click
    self.filterAll_element.when_present.flash.click
    if self.filterBox_element.exists?
      puts "Failure-All filter functionality is not working"
      return false
    else
      puts "Success-All filter functionality is not working"
      return true
    end

  end

  def dublicate_user

    user="duplicate_user"
    self.addUser_element.flash.click
    self.name_element.set(user)
    self.passwd_element.set"Testprime@123"
    self.repasswd_element.set"Testprime@123"
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
      self.buttonok_element.when_present(20).flash.click
    end
    
    self.addUser_element.flash.click
    self.name_element.set(user)
    self.passwd_element.set"Testprime@123"
    self.repasswd_element.set"Testprime@123"
    
    if $browser_type == :ie10
      ind=0
      until @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").present?
        ind=ind+1
        puts"popup ID: #{ind}"
      end
      sleep 20
      @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").span(:text=>"OK",:index=>0).when_present.flash.click
    else
      self.buttonok_element.when_present(20).flash.click
    end
    
    expect="The current user name already exists. Please choose another."
    sleep 2
    actual=self.alertText_element.text
    puts actual
    if expect == actual
      puts "Success-User is not added"
      return true
    else
      puts"Failure-User added successfully"
      return false
    end

  end

  def mandatory_fields

    self.deletealertCancel_element.flash.click
    self.name_element.clear
    self.passwd_element.clear
    self.repasswd_element.clear
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
      self.buttonok_element.when_present.flash.click
    end

    expect="Mandatory Fields are not Valid."
    sleep 2
    actual=self.alertText_element.text
    puts actual
    if expect == actual
      puts "Success-Mandatory field functionality is working"
      return true
    else
      puts"Failure-Mandatory field functionality is not working"
      return false
    end

  end

  def user_role

    self.deletealertCancel_element.flash.click
    self.name_element.set("role_user")
    self.passwd_element.set"TestUser@123"
    self.repasswd_element.set"TestUser@123"
    self.fstname_element.set"FirstTest"
    self.lstname_element.set"LastTest"
    self.email_element.set"Test@cisco.com"
    div_element(:class=>"xwtDialog dijitDialog").input(:id,"viewer").when_present.flash.click
    
    if $browser_type == :ie10
      ind=0
      until @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").present?
        ind=ind+1
        puts"popup ID: #{ind}"
      end
      sleep 20
      @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").span(:text=>"OK",:index=>0).when_present.flash.click
    else
      self.buttonok_element.when_present.flash.click
    end
    expect="At least one role must be selected."
    sleep 2
    actual=self.alertText_element.text
    puts actual
    if expect == actual
      puts "Success-User Role functionality is working"
      return true
    else
      puts"Failure-User Role functionality is not working"
      return false
    end

  end

  def tablerow_selection
    self.deletealertCancel_element.flash.click
    self.buttoncancel_element.flash.click
    self.checkbox_row1_element.when_present.flash.click
    sleep 3
    expect="Selected 1"
    actual=self.rowcount_element.text
    sleep 3
    if expect == actual
      puts"Success-verify row count is working"
      return true
    else
      puts"Success-verify row count is not working"
      return false
    end

  end

  def add_colum

    self.setting_element.when_present.flash.click
    self.colum_element.when_present.flash.click
    self.columRole_element.when_present.flash.click
    self.columRole_element.when_present.flash.click

    sleep 5
    if self.tableRoles_element.present?
      puts "Success-The new column is added on user management table"
      return true
    else
      puts "Failure-The new column is not added on user management table"
      return false
    end

  end

  def reset_colum

    self.columRole_element.when_present.flash.click
    self.columEmail_element.when_present.flash.click
    self.reset_element.when_present.flash.click
    sleep 5
    if self.tableRoles_element.present?
      puts "Success-The new column is Rest on user management table"
      return true
    else
      puts "Failure-The new column is not Reset on user management table"
      return false
    end
  end

  def viewer_user

    self.addUser_element.flash.click
    self.name_element.when_present.set(@@viewer)
    self.passwd_element.when_present.set(@@viewer_pass)
    self.repasswd_element.when_present(3).set(@@viewer_pass)
    self.fstname_element.when_present.set"FirstTest"
    self.lstname_element.when_present.set"LastTest"
    self.email_element.when_present.set"Test@cisco.com"
    if $browser_type == :ie10
      ind=0
      until @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").present?
        ind=ind+1
        puts"popup ID: #{ind}"
      end
      sleep 20
      @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").span(:text=>"OK",:index=>0).when_present.flash.click
    else
      self.buttonok_element.when_present.flash.click
    end

    sleep 5
    on LoginPage do |page|
      puts "comes here"
      page.logoutFromPC
      page.login_with(@@viewer,@@viewer_pass)
      sleep 5
    end
    sleep 30
    self.evaluation_alert()
    self.close_the_popup()
   end



def usernameValid(uname,pwd,rpwd)
  unameinp=uname
  pwdinp=pwd
  rpwdinp=rpwd
  self.addUser_element.click
  self.name_element.set(unameinp)
  self.passwd_element.set(pwdinp)
  self.repasswd_element.set(rpwdinp)
  self.buttonok_element.when_present.click
  if (alert_okbutton_element.exists?)
    puts "InValid User Name"
    self.alert_okbutton_element.when_present.click
    self.buttoncancel_element.click
    return false
  else
    puts "Valid User Name"
  end
  self.filterUsername_element.when_present.clear
  self.filterUsername_element.when_present.set(unameinp)
  sleep 2
  actual=self.usernameText_element.text
  if actual == unameinp
    puts"Added User successfully"
    return true
  else
    puts"Add User Failed"
    return false
  end
end

def usernameInValid(uname,pwd,rpwd)
   unameinp=uname
   pwdinp=pwd
   rpwdinp=rpwd
  self.addUser_element.click
  self.name_element.set(unameinp)
  self.passwd_element.set(pwdinp)
  self.repasswd_element.set(rpwdinp)
  self.buttonok_element.when_present.click
  if (alert_okbutton_element.exists?)
    puts "InValid Password"
    self.alert_okbutton_element.when_present.click
    self.buttoncancel_element.click
    return true
  else
    puts "Valid Password"
    return false
  end
end
  
  def uname_tooltip_value
    self.addUser_element.click
    @browser.span(:id,"UserHelpIcon").fire_event("onmouseover")
    #self.unamehelpicon_element.fire_event("onmouseover")
    actual = self.tooltipvalue_element.text
    self.buttoncancel_element.when_present.click
    return actual
  end

  def pwd_tooltip_value
    self.addUser_element.click
    @browser.span(:id,"PassHelpIcon").fire_event("onmouseover")
    #self.pwdhelpicon_element.fire_event("onmouseover")
    actual = self.tooltipvalue_element.text
    self.buttoncancel_element.when_present.click
    return actual
  end

  def role_mandatory

    self.addUser_element.click
    self.name_element.set("Testusr_10")
    self.passwd_element.set("Testpwd_10")
    self.repasswd_element.set("Testpwd_10")
    div_element(:class=>"xwtDialog dijitDialog").input(:id,"viewer").when_present.click
    self.buttonok_element.when_present.click
    if (alert_okbutton_element.exists?)
      puts "User Role Not Selected"
      self.alert_okbutton_element.when_present.click
      self.buttoncancel_element.click
      return true
    else
      puts "Invalid User Creation"
      return false
    end
  end

end
