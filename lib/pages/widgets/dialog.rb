module Dialog
  include PageObject
  
  div(:dialog) do |page|
    page.div_elements(:class=>'dijitDialog').select{|d| d.visible? && d.class_name.include?('xwtDialog') }.last
  end

  def expect_dialog(message)
    d = nil
    wait_until { d = dialog_element }
    raise "Dialog '#{message}' not found. Found '#{d.text}'" unless d.text =~ /#{message}/
    d 
  end
  
  def submit_dialog(d, label)
    d.span_element(:class=>'dijitButtonNode', :text=>/#{label}/).click
    d.when_not_present
  end
  
  def close_dialog(d)
    d.span_element(:class=>'dijitDialogCloseIcon').click
    d.when_not_present
  end
  
end

module Popup
  include PageObject
  
  div(:popup) do |page|
    page.div_elements(:class=>'dijitPopup').visible_only.last
  end

  # def top_popup
    # p = nil
    # wait_until { p = popup_element }
    # p    
  # end

end

module QuickView
  include PageObject
  
  div(:quickview) do
    qvs = @browser.divs(:class=>'xwtQuickview')
    visible_qvs = qvs.visible_only
    visible_qvs.last || qvs.last
  end

  def open_quickview(anchor, message)
    anchor.hover
    expect_popover(message)
  end

  def close_quickview(qv)
    close_popover qv
  end
  
end

module PopOver
  include PageObject
  
  div(:popover) do
    @browser.divs(:class=>'xwtPopover').visible_only.last
  end

  def expect_popover(message)
    t = nil
    wait_until { t = popover_element }
    sleep 0.5 #wait for animation to get completed 
    raise "Popover '#{message}' not found. Found '#{t.text}'" unless t.text =~ /#{message}/
    t
  end
  
  def pin_popover(po)
    po.div(:class=>'xwtPopoverPin').click
  end

  def close_popover(po)
    po.div(:class=>'xwtPopoverClose').click
    po.wait_while_present
  end
  
end

module Picker
  include PageObject
  include ObjectSelector
  
  def open_picker(picker)
    if ($browser_type == :ff)
      picker.click
    else
      picker.focus
      @browser.send_keys :space
    end
  end
  
  def open_and_set_picker_to(picker, title, path)
    open_picker picker.div_element(:class=>'xwt_BasePickerButton')
    p = expect_popover(title)
    if path == ""
      p.span(:class=>'dijitButtonNode', :text=>/Clear Selections/).click
    else
      select_in_os p.to_page_object_element, path
    end
    raise "Picker was closed unexpectedly" unless p.visible?
    p.span(:class=>'dijitButtonNode', :text=>/OK/).click
  end  
end

