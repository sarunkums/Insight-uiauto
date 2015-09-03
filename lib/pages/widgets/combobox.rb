module ComboBox
  include PageObject

  def combobox_value(combobox)
    combobox.text_field_element(:class=>'dijitInputInner').value    
  end
  
  def combobox_menu_for(combobox)
    id = combobox.attribute "id"
    self.div_element(:id=>"#{id}_dropdown")
  end
  
  def open_combobox(combobox)
    arrow = combobox.div(:class=>'dijitDownArrowButton')
    arrow.focus
    arrow.click
    combobox_menu_for(combobox).when_present
  end
    
  def get_combobox_items(combobox)
    open_combobox combobox unless combobox_menu_for(combobox).visible?
    combobox_menu_for(combobox).list_item_elements(:tag_name=>'li')
  end
  
  def select_combobox_item(combobox, item)
    item = "&nbsp;" if item == ""
    get_combobox_items(combobox).select{|li| li.text==item || li.html=~/#{item}/}.first.click
  end
  
end