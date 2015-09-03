require 'common/flex_utils' # for TreeTable

module Widgets
  include PageObject
  include Navigation
  include ObjectSelector
  include Alert
  include Toaster
  include Dialog
  include TaskNavigator
  include Popup
  include Table
  include TitlePane
  include View
  include Dashlet
  include ComboBox
  include PopOver
  include Chart
  include Picker
  include QuickView
  include SmartServices
  include CommonAction
  
  
  def width_of(widget)
    widget.element.wd.size.width.to_i
  end
  
  def height_of(widget)
    widget.element.wd.size.height.to_i
  end
  
  def top_once_scrolled_into_view_of(widget)
    widget.element.wd.location_once_scrolled_into_view.y
  end
 
  def top_of(widget)
    widget.element.wd.location.y
  end
  
  def browser_size
    $browser_size || @browser.window.size
  end
  
  # delta>0, down
  # delta<0, up
  def scroll_page_by(delta)
    # puts "SCROLLING BY #{delta}"
    @browser.div(:class=>'wap-contentPanel').focus
    @browser.execute_script "window.scrollBy(0,#{delta})"
  end
  
  def center_object_in_wap(widget)
    # puts widget.class_name
    # top = top_of widget
    # puts "TOP BEFORE SCROLLING=#{top}"
    # STDIN.gets
    top = top_once_scrolled_into_view_of widget #doesnt work well with ff and ie
    # puts "SCROLLED INTO VIEW AT #{top}"
    # STDIN.gets
    top = top_of widget unless ($browser_type == :gc) || ($browser_type == :ff) 
    # puts "TOP=#{top}"
    # STDIN.gets
    margin = 100
    available_height = browser_size[1] - 2 * margin
    # puts "AV H=#{available_height}"
    # puts "H=#{height_of(widget)}"
    ideal_top = margin + (available_height - height_of(widget)) / 2
    # puts "IDEALTOP=#{ideal_top}"
    scroll_page_by( top - ideal_top )
    # STDIN.gets
    widget # return widget so this can be used as a=center_object_in_wap(widget)
  end
  
end

