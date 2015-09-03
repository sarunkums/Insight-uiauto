module SmartServices
  include PageObject
  
  div(:login_lite, :class=>'loginlite')
  div(:sr_panel, :class=>'SRPanel')
  div(:sr_panel_ct) { sr_panel_element.div_element(:class=>'xwtContextualToolbar') }
  div(:sr_create_panel, :class=>'supportCaseScreenTwo')
  
  div(:support_community_panel, :class=>'cscForumWindow')
  
  
  def open_settings_support_cases
    settings_menu = open_settings
    settings_menu.td(:text=>'Support Cases').when_present.click
  end
  
  def open_support_community_dialog
    settings_menu = open_settings
    settings_menu.td(:text=>"Support Community").click
    support_community_panel_element.when_present
  end
  
  def login_smart_services(user="admin", pwd="admin")
    login_lite_element.when_visible.text_field_element(:name=>'username').set user
    login_lite_element.text_field_element(:name=>'password').set pwd
    login_lite_element.span_element(:class=>'dijitButtonNode', :text=>/Log In/).click
  end
  
  def case_list_panel
    sr_panel_element
  end
  
  def case_list_panel_close
    # sr_panel_element.span_element(:class=>'dijitDialogCloseIcon').focus
    # $browser.send_keys :space
    sr_panel_element.when_visible
    $browser.send_keys :escape
    sr_panel_element.when_not_visible
  end
  
  def create_new_case
    click_button_in(sr_panel_ct_element, "Create")
  end
  
  def case_create_panel
    sr_create_panel_element
  end
  
end