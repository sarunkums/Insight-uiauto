class GettingStarted  < AppPage

  div(:wizardContent,:class=>"wizardContent")
  div(:donotShow,:class=>"dontShowNode")
  div(:systemSetupPages,:class=>"linkNode",:index=>0)
  div(:userManamgement){systemSetupPages_element.div_element(:class=>"columnLink",:text=>"Manage Users and Roles")}
  div(:dataSources){systemSetupPages_element.div_element(:class=>"columnLink",:text=>"Data Sources")}
  div(:reportsPages,:class=>"linkNode",:index=>1)
  div(:customViews){reportsPages_element.div_element(:class=>"columnLink",:text=>"Custom Views")}
  div(:savedReports){reportsPages_element.div_element(:class=>"columnLink",:text=>"Saved Reports")}
  checkbox(:checkBox){donotShow_element.checkbox_element(:class=>"dijitCheckBoxInput")}

  def gettingStartedPopUP_Options

    systemSetup=[]
    self.systemSetupPages_element.flash
    all=@browser.div(:class=>"linkNode",:index=>0).divs(:class=>"columnLink")
    all.each do |p|
      systemSetup<<p.title
    end
    puts "System Setup Pages: #{systemSetup}"
    reports=[]
    self.reportsPages_element.flash
    reportall=@browser.div(:class=>"linkNode",:index=>1).divs(:class=>"columnLink")
    reportall.each do |p|
      reports<<p.title
    end
    puts "Reports Pages: #{reports}"

    systemSetupExpect=["Manage Users and Roles","Data Sources","Smart License"]
    reportsExpect=["Custom Views","Saved Reports"]
    if systemSetup == systemSetupExpect
      puts"Success-SystemSetup option is displayed"
      return true
    else if reports =reportsExpect
        puts "Success-Reports option is displayed"
        return true
      else
        puts "Failure-SystemSetup,Reports option is not displayed"
        return false
      end
    end

  end

  def gettingStartedPopUP_checkBoxUnchecked
    self.globaladmin_element.flash.click
    self.gettingstart_element.flash.click
    sleep 3
    return self.checkBox_element.checked?
  end

  def gettingStartedPopUP_checkBoxChecked
    self.checkBox_element.click
    sleep 3
    return self.checkBox_element.checked?
  end

end