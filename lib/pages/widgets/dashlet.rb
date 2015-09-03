#require './spec/spec_helper.rb'
module Dashlet
  include PageObject

#Dashboard
  def dashlets_in(dashboard)
    dashboard.div_elements(:class=>'xwtDashletPaneTitle').map{|dashlet| dashlet.text}
  end
  
  def dashlet_in(dashboard, dashlet_title)
    #dashboard_element.div_element(:class=>'xwtDashlet', :text=>/#{dashlet_title}/).when_present
    # much faster version! Avoid regex and directly filter on text of children divs!
    dashboard.div_elements(:class=>'xwtDashlet').select{|d| d.div_element(:class=>"xwtTitlePaneTextNode").text == dashlet_title}.first
  end
  
  def global_filters_in(dashboard)
    dashboard.div_elements(:class=>'dbFilter').collect{|f| f.text}
#      puts "filter: #{f}"
  end
  
  
# Dashlets
  def dashlet_button(dashlet, button_label)
    dashlet.div_element(:class=>"xwtTitlePaneTextNode").hover
    dashlet.span_elements(:class=>'dijitButtonContents').select{|b| b.title==button_label}[0]
  end
  
  def dashlet_buttons(dashlet)
    dashlet.div_element(:class=>"xwtTitlePaneTextNode").hover
    dashlet.span_elements(:class=>'dijitButtonContents').select{|b| b.title != ""}.collect{|b| b.title}
  end
  
  def dashlet_drag_to(dashlet, dx, dy)
    dashlet_title = dashlet.div_element(:class=>'xwtTitlePaneTitle')
    raise "TODO support for SAFARI drag and drop" if $browser_type == :safari 
    dashlet_title.drag_and_drop_by dx, dy
  end

  def collapse_dashlet(dashlet)
    dashlet_button(dashlet, "Collapse/Expand").click
  end
  
  def has_dashlet_collapsed?(dashlet)
    dashlet.class_name.include? 'xwtDashletCollapsed'
  end

  def detach_dashlet(dashlet)
    dashlet_button(dashlet, "Detach").click
  end

  def refresh_dashlet(dashlet)
    dashlet_button(dashlet, "Refresh").click
    sleep 2
  end

  def close_dashlet(dashlet)
    dashlet_button(dashlet, "Close").click
  end
    
  def title_of(dashlet)
    dashlet.div_element(:class=>"xwtTitlePaneTextNode").text
  end

# Dashlet Edit
  def dashlet_edit_pane(dashlet)
    dashlet.div_element(:class=>"dashletEditNode")
  end

  def open_dashlet_edit(dashlet)
    dashlet_button(dashlet, "Edit").click
    sleep 0.5
    dashlet_edit_pane(dashlet)
  end
  
  def save_and_close_dashlet_edit_pane(dashlet)
    dashlet_edit_pane(dashlet).span_element(:class=>'dijitButtonText', :text=> /Save and Close/).click
    sleep 0.5
  end
  
  def dashlet_filter(dashlet, filter)
    pane = dashlet_edit_pane(dashlet)
    if pane.div_element(:class=>'dashletFilterLabel', :text=>filter).exists?
      filter = pane.div_element(:class=>'dashletFilterLabel', :text=>filter).parent.parent
    else
      filter = pane.div_element(:class=>'genericDashletLabel', :text=>filter).parent
    end
    filter
  end
  
  def dashlet_filter_textbox(dashlet, filter)
    dashlet_filter(dashlet, filter).text_field_element(:index=>0)
  end
  
  def dashlet_filter_combobox(dashlet, filter)
    dashlet_filter(dashlet, filter).div_element(:class=>'xwtComboBox')
  end
  
  def dashlet_filter_picker(dashlet, filter)
    dashlet_filter(dashlet, filter).div_element(:class=>'xwt_BasePicker')
  end
  
  def dashlet_filter_textbox_value(dashlet, filter)
    dashlet_filter_textbox(dashlet, filter).value
  end
  
  def set_dashlet_filter_textbox(dashlet, filter, value)
    dashlet_filter_textbox(dashlet, filter).set value
  end
  
  def dashlet_filter_combobox_value(dashlet, filter)
    combobox = dashlet_filter_combobox(dashlet, filter)
    combobox_value combobox.to_page_object_element
  end
  
  def set_dashlet_filter_combobox(dashlet, filter, value)
    combobox = dashlet_filter_combobox(dashlet, filter)
    select_combobox_item combobox.to_page_object_element, value
  end
  
  def set_dashlet_filter_picker(dashlet, filter, title, value)
    picker = dashlet_filter_picker(dashlet, filter)
    open_and_set_picker_to picker.to_page_object_element, title, value
  end
  
  def lock_dashlet_filter(dashlet, filter)
    dashlet_filter(dashlet, filter).checkbox.set
  end

  def dashlet_filter_locked?(dashlet, filter)
    dashlet_filter(dashlet, filter).checkbox.set?
  end

  def has_funnel?(dashlet)
    dashlet.div_element(:class=>'filterIcon').visible?
  end
  
  def hover_funnel_of(dashlet)
    dashlet.div_element(:class=>'filterIcon').hover
  end
  
# Dashlet Lower Bar
  def dashlet_bottom_icons(dashlet)
    dashlet.div_element(:class=>'bottomRegion').div_elements(:class=>'icon').collect {|d| d.title}
  end
  
  def dashlet_bottom_timestamp(dashlet)
    dashlet.div_element(:class=>'chartTimestamp').text
  end
  
# Metric Dashlets
  def metric_dashlets_in(metric_panel)
    return [] unless metric_panel
    metric_panel.div_elements(:class=>'dashboardMetricItemTitle').visible_only.map{|metric_dashlet| metric_dashlet.text}
  end
  
  def dashlet_search(search)
    div_element(:text=>"Add Dashlet(s)").focus
    div_element(:text=>"Add Dashlet(s)").click
    div_element(:class=>"dashlet item selected").div(:class=>"searchBox").text_field(:class=>"dijitReset dijitInputInner").click 
    div_element(:class=>"dashlet item selected").div(:class=>"searchBox").text_field(:class=>"dijitReset dijitInputInner").set(search)
#    sleep 3
#    a=@browser.div(:class=>"smAccordion").id
#    puts "id value: #{a}"
#    sleep 3
#    @browser.div(:id,"#{a}").div(:class=>"smContent show").div(:class=>"smItemAction").click
    
#    @browser.div(:id,"#{a}").div(:class=>"smItem",:index=>1).div(:text=>"Add").flash
#    @browser.div(:id,"#{a}").div(:class=>"smItem",:index=>1).div(:text=>"Add").click
#    div_element(:class=>"smContent show").div(:class,"smItemAction").when_present.click
  end
  

end