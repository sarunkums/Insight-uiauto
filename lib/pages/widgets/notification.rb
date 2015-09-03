module Alert
  include PageObject
  div(:alert) do
     self.div_elements(:class=>'xwtAlert').visible_only.last
     # self.div_element(:id=>'dijitDialog xwtAlert')
  end
  
  def expect_alert(message)
    puts "get into expect alert"
    a = nil
    wait_until(3, "No Alert found.") {
      a = alert_element
    }
    sleep 1 #wait for animation to get completed 
    raise "Alert '#{message}' not found. Found '#{a.text}'" unless a.text =~ /#{message}/
    a
  end
  
  def alert_ok
    alert_button "OK"
  end
  
  def alert_cancel
    alert_button "Cancel"
  end

  def alert_button(label)
     alert_element.span_element(:class=>"xwtButton", :text=>/#{label}/).when_present.span_element.click
    # alert_element.span_element(:class=>"dijitReset dijitInline dijitButtonText", :text=>/#{label}/).when_present.click
  end
  
  def dont_show_again_this_message
    alert_element.div_element(:class=>"xwtDontShowAgainMessage").checkbox_element.check
  end
  
  def dismiss_any_present_alert
    begin
      alert_element.when_present
      sleep 1
    rescue
      return
    end
    alert_ok
  end
end


module Toaster
  include PageObject
  
  div(:toaster) do
    
     self.div_elements(:class=>'xwtToasterWrapper').visible_only.last
#    sleep 3
#    @browser.div(:class=>'xwtToasterWrapper').visible_only.last
  end

  def expect_toaster(message, timeout=10)
    t = nil
    wait_until(timeout, "No Toaster found.") { t = toaster_element }
    sleep 1 #wait for animation to get completed 
    raise "Toaster '#{message}' not found. Found '#{t.text}'" unless t.text =~ /#{message}/
    t
  end
  
  def close_toaster(t)
    if $browser_type == :safari 
      t.div_element(:class=>'xwtCloseIcon').click
    else # FF, GC, IE
      t.div_element(:class=>'xwtCloseIcon').focus
      $browser.send_keys :space
    end
    t.when_not_present
  end
  
end
