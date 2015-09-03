class TelemetryPage  < AppPage

  div(:telemetrydialog,:id=>"success_dailog")
  checkbox(:yescheck,:id=>"par_check")
  checkbox(:nocheck,:id=>"nopar_check")
  span(:button_accept,:text=>"Accept")
  span(:button_Cancel,:text=>"Cancel")
  span(:whatconnect,:id=>"sp_sampdata")
  div(:whtconnhead,:id=>"treeset_dialog")
  span(:close_icon){whtconnhead_element.span(:class=>"dijitDialogCloseIcon")}

  
  def defaultchk
    @browser.div(:id=>"success_dailog").div(:index=>4).div(:index=>5).flash.text
  end

  def connect_info
    self.whatconnect_element.flash.click
    sleep 3
    actual=[]
    for i in 1..3
      p=@browser.div(:class=>"dijitTreeContainer").span(:class=>"dijitTreeLabel",:index=>i).flash.text
      actual<<p
    end
    self.close_icon_element.flash.click
    return actual
  end

  def chk_enabled
    if self.nocheck_element.set?
      puts "No check is set"
    else
      self.nocheck_element.click
      self.button_accept_element.flash.click
      sleep 3
      self.globaladmin_element.flash.click
      self.helpus_element.flash.click
      sleep 3
    end
    self.yescheck_element.click
    self.button_accept_element.flash.click
    sleep 3
    self.globaladmin_element.flash.click
    self.helpus_element.flash.click
    sleep 3
    actual = @browser.div(:id=>"success_dailog").div(:index=>4).div(:index=>5).flash.text  
    return actual
  end

end
