module ObjectSelector
  include PageObject
  
  #public
  
  def os_loaded?(widget)
    widget.visible? && ! is_os_loading?
  end
  
  def is_os_loading?
    @browser.divs(:class => "xwtOSWaitIndicator").select{|item| item.div.visible?}.size > 0
  end
  
  def select_in_os(widget, path)
    if has_tree_view_for? widget then
      #Tree View
      drilldown(widget, path)
    else
      #List View
      browse_list(widget, path)
    end
  end
  
  def drilldown(node, path)
    begin
      name, *other_names = path.split("=>")
      current_node = os_tree_node(node, name)
      current_node.present?
    rescue Exception => e  
      puts e.message
      raise "Object Selector node #{name} not found"
    end
    if other_names.empty? then
      select_os_tree_node current_node
    else
      expand_os_tree_node current_node
      new_path = other_names.size==1 ? other_names[0] : other_names.join("=>") 
      drilldown(current_node, new_path)
    end
  end
  
  def browse_list(widget, path)
    begin
      name, *other_names = path.split("=>")
      current_node = os_list_node(widget, name)
      current_node.present?
    rescue Exception => e  
      puts e.message
      raise "Object Selector node #{name} not found"
    end
    if other_names.empty? then
      select_os_list_node current_node
    else
      navigate_os_list_node widget, current_node
      new_path = other_names.size==1 ? other_names[0] : other_names.join("=>") 
      browse_list(widget, new_path)
    end
  end
  
  def selected_node_in(widget)
    if has_tree_view_for? widget then
      #Tree View
      selected = widget.div_element(:class=>"dijitTreeRowSelected")
      label_of_tree_node(selected).text
    else
      #List View
      selected = widget.div_element(:class=>"xwtObjectSelectorItemHighlighted")
      label_of_list_node(selected).text
    end
  rescue
    #return nil if no node is selected  
  end
  
  def has_tree_view_for?(widget)
    view_mode_button_of(widget).div_element(:class=>'xwtObjectSelectorIconToggle').class_name.include? "xwtObjectSelectorIconTreeNormal"
  end
  
  def has_list_view_for?(widget)
    view_mode_button_of(widget).div_element(:class=>'xwtObjectSelectorIconToggle').class_name.include? "xwtObjectSelectorIconTableNormal"
  end
  
  def toggle_view_mode_of(widget)
    view_mode_button_of(widget).click
  end
  
  private
  
  def os_tree_node(widget, name)
    children_tree_nodes_of(widget).select {|n| label_of_tree_node(n).text == name.strip}.first
  end
  
  def os_list_node(widget, name)
    list_nodes_of(widget).select {|n| label_of_list_node(n).text == name.strip}.first
  end
  
  def label_of_tree_node(node)
    node.span_elements(:class => "dijitTreeLabel").visible_only.first
  end

  def label_of_list_node(node)
    #class can be xwtObjectSelectorListText or xwtObjectSelectorListTextAligned
    node.div_elements(:class => /xwtObjectSelectorListText/).visible_only.first
  end
  
  def tree_node_expanded?(node)
    label_of_tree_node(node).attribute("aria-expanded")=="true"
  end
  
  def expand_os_tree_node(node)
    node.span_elements(:class=>"dijitTreeExpando").visible_only.first.click unless tree_node_expanded?(node)
    wait_until(5,"No children found for node #{label_of_tree_node(node).text}") { children_tree_nodes_of(node).count > 0 }
  end
  
  def navigate_os_list_node(widget, node)
    label = label_of_list_node(node).text
    node.div_elements(:class=>"xwtObjectSelectorListNav").visible_only.first.click
    sleep 2
    wait_until(5,"No children found for node #{label}") { list_nodes_of(widget).count > 0 }
  end
  
  def children_tree_nodes_of(node)
    node.div_elements(:class=>"dijitTreeNode").visible_only
  end

  def list_nodes_of(widget)
    widget.div_elements(:class=>"xwtObjectSelectorItem").visible_only
  end
  
  def select_os_tree_node(node)
    label_of_tree_node(node).click
    sleep 2
  end
  
  def select_os_list_node(node)
    label_of_list_node(node).click
    sleep 2
  end
  
  def view_mode_button_of(widget)
    widget.table_element(:class=>'xwtOStoolToggle').cell_element
  end
  
end