module Navigation
  include PageObject
  
  div(:hamburger, :class=>'toggleNode')
  div(:menu, :class=>'xwtSlideMenu')
  div(:menu_pin, :class=>'xwtSliderMenuPinIcon')
  span(:menu_navigation, :class=>'dijitButtonContents', :title => "Navigation")
  span(:menu_index,      :class=>'dijitButtonContents', :title => "Index")
  span(:menu_favorites,  :class=>'dijitButtonContents', :title => "Favorites")
  div(:alphabet_bar, :class=>'xwtSlideMenuIndexThumbNav')
  div(:slideout_menu_pane) { self.div_elements(:class=>'xwtSlideOutNavigationMenu').visible_only.first }
  
  div(:global_breadcrumb, :class=>'globalBreadcrumb')
  div(:global_breadcrumb_toolbar, :class=>'globalToolbar')
#  div(:context_tab, :class=>'contextLevelNavigation')
#  div(:third_tab_nav, :class=>'thirdLevelNavigation')
  div(:view_tab, :class=>'xwtScrollingTabController') # 'tabbedNavigationList')
#  div(:workbench, :class=>'workbench')
  div(:dashboard_tab) { div_element(:class=>'tabDashboard dijitTabContainerTop-tabs') }
  div(:dashboard_filter_pane) { div_elements(:class=>'dashboardFilter').select{|f| f.visible?}.first }
  
  # span(:dashboard_config_button) do
    # dc = div_element(:class=>'tabDashboard dijitTabContainerTop').when_present.div_elements(:class=>'tabStripButton').visible_only.first
    # dc.span_element(:class=>'settingsIcon').span_element
  # end
  div(:page_header,      :class=>'pageHeader')
  div(:page_title,       :class=>'pageTitleLabel') 
  div(:page_breadcrumbs, :class=>'pageBreadcrumb')
  div(:page_toolbar,     :class=>'pageToolbar') 

  span(:dashboard_config_button) { div_element(:class=>'tabDashboard dijitTabContainerTop').span_element(:class=>'settingsIcon').span_element }
  div(:dashboard_config_panel) { div_elements(:class=>'dashboardConfig').first ||
                                 div_element(:class=>'dashboardConfig') }
  
  #Menu
  def navigate_application_to(path)
    links = path.split("=>")
    
    open_menu
    click_menu_item links
    wait_until { ! menu_is_open? } 
  end
  
  def open_menu
    #dismiss_dialogs_if_present # shouldnt be needed here, but..
    sleep 1
    unless menu_is_open?
      hamburger_element.click
      wait_until(1) { menu_is_open? }
    end
  end
  
  def close_menu
    if menu_is_open?
      if slideout_menu_pane_element
        dismiss_slideout_menu_pane # closes navigation menu too..
      else 
        hamburger_element.click
        wait_until(1) { ! menu_is_open? }
      end 
    end
  end
  
  def menu_is_open?
    menu_element.visible? 
#    && left_of(menu_element) >= 0   # - Need to discuss with Stefano
  end
  
  def menu_labels
    open_menu
    menu_element.div_elements(:class=>'xwtSlideMenuLevel0').collect{ |menu_item| 
      if is_slideout?(menu_item) 
        menu_item.div_element(:class=>'xwtSlideOutNavigationButtonTitle').text
      else 
        menu_item.span_element(:class=>'dijitTitlePaneTextNode').text
      end
    }
  end

  def menu_pane_with_label(label)
    begin
      menu_item = menu_element.div_elements(:class=>'xwtSlideMenuLevel0').select{|d| d.text =~ /#{label}/}.first
      menu_item
    rescue
      raise "Menu with label #{label} not found in #{menu_element.text}"
    end
  end
  
  def is_slideout?(menu_item)
    menu_item.class_name.include? "xwtSlideOutNavigationButton"
  end
    
  def dismiss_slideout_menu_pane
    slideout_menu_pane_element.div_element(:class=>'xwtSlideOutNavigationButtonTitle').click
    sleep 1
  end
  
  def open_menu_pane(menu_item)
    if is_slideout?(menu_item) 
      begin 
        menu_item.click
        sleep 1
      end unless menu_pane_is_open?(menu_item)
      menu_pane = slideout_menu_pane_element
    else 
      begin
        menu_item.focus # solves problem introduced with fix of CSCun67321. Now IE has issues with bringing link into view, which sometimes causes clicking on upper area of the menu
        menu_item.span_element(:class=>'dijitTitlePaneTextNode').click #need this span to avoid using location_once_scrolled_into_view
        sleep 1
      end unless menu_pane_is_open?(menu_item)
      menu_pane = menu_item
    end
    menu_pane
  end
  
  def menu_pane_is_open?(menu_item)
    if is_slideout?(menu_item)
      menu_item.class_name.include? "dijitOpen"
    else 
      menu_item.div_element(:class=>'dijitTitlePaneTitle').class_name.include? "dijitOpen"
    end
  end
  
  def group_pane(path)
    labels = path.split("=>")
    lev0_menu = open_menu_pane menu_pane_with_label labels[0]
    lev0_menu.div_elements(:class=>'xwtSlideMenuLevel1').select{|d| d.div_element(:class=>'xwtSlideMenuMenuItemText', :text => labels[1]).present?}.first.parent
  end

  def subgroup_pane(path)
    labels = path.split("=>")
    lev1_pane = group_pane(labels[0..1].join("=>"))
    lev1_pane.div_elements(:class=>'xwtSlideMenuLevel2').select{|d| d.div_element(:class=>'xwtSlideMenuMenuItemText', :text => labels[2]).present?}.first.parent
  end
  
  def click_menu_item(labels)
    lev0_menu = open_menu_pane menu_pane_with_label labels[0]
    return if labels.size == 1 # case when we specified menu only
      
    if labels.size == 2 # case when we specified group or link 
      link = lev0_menu.div_element(:class=>'xwtSlideMenuMenuItemText', :text=>labels[1])
    elsif labels.size == 3 # case when we specified group and link 
      group = lev0_menu.div_elements(:class=>'xwtSlideMenuLevel1').select{|d| d.div_element(:class=>'xwtSlideMenuMenuItemText', :text => labels[1]).present?}.first.parent
      link  = group.div_element(:class=>'xwtSlideMenuLevel2', :text => labels[2]).div_element(:class=>'xwtSlideMenuMenuItemText')
    elsif labels.size == 4 # case when we specified group and subgroup and link
      group = lev0_menu.div_elements(:class=>'xwtSlideMenuLevel1').select{|d| d.div_element(:class=>'xwtSlideMenuMenuItemText', :text => labels[1]).present?}.first.parent
      subgr = group.div_elements(:class=>'xwtSlideMenuLevel2').select{|d| d.div_element(:class=>'xwtSlideMenuMenuItemText', :text => labels[2]).present?}.first.parent
      link  = subgr.div_element(:class=>'xwtSlideMenuLevel3', :text => labels[3]).div_element(:class=>'xwtSlideMenuMenuItemText')
    end
    link.focus # solves problem introduced with fix of CSCun67321. Now IE has issues with bringing link into view, which sometimes causes clicking on upper area of the menu
    link.click
    sleep 1
    if link.visible?
      puts "WARNING: Click on Navigation Menu item did not work, retrying..."
      link.click
    end
  end

  #Context and Third level tabs
  # def select_context_tab(label)
    # context_tab_element.span_element(:class=>'textLabelSpan', :text=>label).click
  # end
# 
  # def selected_context_tab
    # context_tab_element.list_item_element(:class=>'selected').text
  # end
# 
  # def select_third_tab(label)
    # third_tab_nav_element.span_element(:class=>'textLabelSpan', :text=>label).click
  # end
# 
  # def selected_third_tab
    # third_tab_nav_element.list_item_element(:class=>'selected').text
  # end

  #Global Breadcrumb
  def global_breadcrumb_home
    global_breadcrumb_element.div_element(:class=>'breadCrumbHomeIcon')
  end
  
  def global_breadcrumb_ellipses
    global_breadcrumb_element.span_element(:class=>'xwtEllipses')
  end
  
  def global_breadcrumb_hidden_path
    global_breadcrumb_ellipses.title
  end
    
  def global_breadcrumb_visible_path
    global_breadcrumb_element.span_element(:class=>'xwtBreadcrumb').span_elements.map {|i| i.text}.join.gsub(/\n/,"")
  end
    
  def global_breadcrumb_complete_path
    global_breadcrumb_ellipses.click if global_breadcrumb_ellipses.present?
    global_breadcrumb_visible_path
  end
  
  def global_breadcrumb_item(label)
    global_breadcrumb_element.span_element(:class=>'xwtBreadcrumb').span_element(:text=>label)
  end
  
  # New Global Toolbar is inside the Global Breadcrumb toolbar
  def global_breadcrumb_toolbar_icons
    toolbar_icons(global_breadcrumb_toolbar_element)
  end
  
  def global_breadcrumb_toolbar_icon(label)
    toolbar_icon(global_breadcrumb_toolbar_element, label)
  end
  
  def add_to_favorites
    global_breadcrumb_element.div_element(:class=>'xwtNavBreadcrumbFavoriteIcon').click
  end

  # New Page Toolbar is inside the Global Breadcrumb toolbar
  def page_toolbar_links
    toolbar_links(page_toolbar_element)
  end
  
  def page_toolbar_link(label)
    toolbar_link(page_toolbar_element, label)
  end
  
  #Dashboard
  def select_dashboard_tab(label)
    center_object_in_wap global_breadcrumb_element
    dashboard_tab_element.span_element(:class=>'tabLabel', :text=>label).click
  end

  def selected_dashboard_tab
    dashboard_tab_element.div_element(:class=>'dijitTabChecked').text
  end
  
  def select_dashboard_config_item(label)
#    item = dashboard_config_panel_element.div_element(:class=>'actionTitle',:index=>0,:text=>label).when_present(10)
    item = dashboard_config_panel_element.div_element(:class=>'actionTitle',:text=>label)
    if $browser_type == :ie
      item.focus
      item.send_keys :enter
    else
      item.click
    end
  end
  
  def add_dashboard_tab(label)
    open_dashboard_config_panel
    select_dashboard_config_item('Add New Dashboard')
    dashboard_config_panel_element.div_element(:class=>'add').text_field_element.set label
    dashboard_config_panel_element.div_element(:class=>'add').span_element(:class=>'xwtButton', :text=>/Apply/).span_element.click
  end
  
  def close_dashboard_tab(label)
    center_object_in_wap global_breadcrumb_element
    tab = dashboard_tab_element.div_element(:class=>'dijitTabContent', :text=>/#{Regexp.escape label}/)
    tab.span_element(:class=>'dijitTabCloseButton').when_present.click
  end
  
  #Dashboard configuration
  def open_dashboard_config_panel
    center_object_in_wap dashboard_config_button_element
    dashboard_config_button_element.click unless dashboard_config_panel_element.visible?
  end
  
  def close_dashboard_config_panel
    dashboard_config_button_element.click if dashboard_config_panel_element.visible?
  end
    
  def reset_dashboard
    open_dashboard_config_panel
    #firefox needs class to be specified below:
    reset = dashboard_config_panel_element.div_element(:class=>'manageLink', :text=>'Reset all Dashboards')
    select_dashboard_config_item('Manage Dashboards') unless reset.visible?
    reset.click
  end

  def mark_as_default_dashboard
    open_dashboard_config_panel
    select_dashboard_config_item('Manage Dashboards')
    #firefox needs class to be specified below:
    dashboard_config_panel_element.div_element(:class=>'manageLink', :text=>'Mark as Default Dashboard').when_present.click
  end
  
  def rename_dashboard_as(new_label)
    open_dashboard_config_panel
    select_dashboard_config_item('Rename Dashboard')
    dashboard_config_panel_element.div_elements(:class=>'dcTextBox').visible_only.first.text_field_element.set new_label
    dashboard_config_panel_element.span_element(:class=>'xwtButton', :text=>/Apply/).span_element.click
  end
  
  def dashboard_filter(filter)
    center_object_in_wap dashboard_filter_pane_element.div_element(:class=>'dbFilter', :text=>/#{filter}/)
  end
  
  def filter_icon_of(filter)
    filter.div_element(:class=>/(dbF|dashletF|f)ilterIcon/)
  end
  
  def filter_title_of(filter)
    filter.div_element(:class=>'dbFilterLabel').text
  end
  
  def filter_type_of(filter)
    if    filter.div_element(:class=>'xwt_AnchoredOverlay').present?
      :toggle_panel
    elsif filter.div_element(:class=>'xwt_BasePicker').present?
      :toggle_picker
    elsif filter.div_element(:class=>'xwtComboBox').present?
      :combobox
    elsif filter.div_element(:class=>'dijitTextBox').present?
      :textbox
    end
  end
  
  def dashboard_filter_textbox(filter)
    dashboard_filter(filter).div_element(:class=>'dijitInputField').text_field_element(:index=>0)
  end
  
  def dashboard_filter_combobox(filter)
    dashboard_filter(filter).div_element(:class=>'xwtComboBox')
  end
  
  def dashboard_filter_picker(filter)
    dashboard_filter(filter).div_element(:class=>'xwt_BasePicker')
  end
  
  def apply_dashboard_filter
    dashboard_filter_pane_element.span_element(:class=>'xwtButton', :text=>/Apply/).span_element.click
    sleep 1    
  end
  
  def set_dashboard_filter_textbox(filter, value)
    dashboard_filter_textbox(filter).set value
    apply_dashboard_filter
  end
  
  def set_dashboard_filter_combobox(filter, value)
    combobox = dashboard_filter_combobox(filter)
    select_combobox_item combobox, value
    apply_dashboard_filter
  end
  
  def set_dashboard_filter_picker(filter, title, value)
    picker = dashboard_filter_picker(filter)
    open_and_set_picker_to picker.to_page_object_element, title, value
    apply_dashboard_filter
  end
    
  def set_dashboard_layout_as(layout)
    open_dashboard_config_panel
    select_dashboard_config_item('Layout Template')
    dashboard_config_panel_element.div_element(:class=>'layoutRadio', :text=>layout).radio_button_element.click
    close_dashboard_config_panel
  end

  def open_export_dashboard
    open_dashboard_config_panel
    select_dashboard_config_item('Export')
    expect_dialog('Export')
  end
  
  def export_dashboard(params={:as => :csv})
    export_dialog = open_export_dashboard
    export_dialog.radio(:label=>"CSV").click if params[:as] == :csv
    export_dialog.radio(:label=>"PDF").click if params[:as] == :pdf
    export_dialog.span(:class=>"xwtButton", :text=>/Export/).span.click
  end
  
  def config_subpanel(title)
    dashboard_config_panel_element.div_elements(:class=>"item").select{|d| d.div_element(:class=>'actionTitle', :text=>title).present?}[0].div_element(:class=>'content')
  end
  
  def open_config_subpanel(title)
    select_dashboard_config_item(title) unless config_subpanel(title).visible?
  end
  
  def open_config_dashlet_type(subpanel, type)
    title = subpanel.div_element(:class=>'accordionTitleNode', :text=>/#{type}/)
    title.click unless title.class_name.include? 'downArrow'
  end
  
  def add_dashlet(type, label)
    open_dashboard_config_panel
    open_config_subpanel "Add Dashlet(s)"
    subpanel = config_subpanel "Add Dashlet(s)"
    open_config_dashlet_type(subpanel, type)
    subpanel.div_element(:class=>'smItem', :text=>/#{label}/).div_element(:text=>'Add').when_present.flash.click
  end
  
  #def close_dashlet(label) already defined in dashlet.rb
  
  def add_filter(label)
    open_dashboard_config_panel
    open_config_subpanel "Add or Remove Filter(s)"
    subpanel = config_subpanel "Add or Remove Filter(s)"
    subpanel.div_element(:class=>'dbActionItem', :text=>/#{label}/).div_element(:text=>'Add').click
  end
  
  def remove_filter(label, how = :from_menu)
    if how == :from_menu
      open_dashboard_config_panel
      open_config_subpanel "Add Filter(s)"
      subpanel = config_subpanel "Add Filter(s)"
      subpanel.div_element(:class=>'dbActionItem', :text=>/#{label}/).div_element(:text=>'Remove').click
    elsif how == :by_close_icon
      dashboard_filter(label).hover
      dashboard_filter(label).div_element(:class=>"closeIcon").click
    #else ignore
    end
  end
    
  def add_metric_dashlet(type, label)
    open_dashboard_config_panel
    open_config_subpanel "Add Metric Dashlet(s)"
    subpanel = config_subpanel "Add Metric Dashlet(s)"
    open_config_dashlet_type(subpanel, type)
    subpanel.div_element(:class=>'smItem', :text=>/#{label}/).div_element(:text=>'Add').click
  end
  
  def remove_metric_dashlet(type, label)
    open_dashboard_config_panel
    open_config_subpanel "Add Metric Dashlet(s)"
    subpanel = config_subpanel "Add Metric Dashlet(s)"
    open_config_dashlet_type(subpanel, type)
    subpanel.div_element(:class=>'smItem', :text=>/#{label}/).div_element(:text=>'Remove').click
  end
  
  #View tabs   ..supposing there's one view only..
  def select_view_tab(label)
    view_tab_element.span_element(:class=>'tabLabel', :text=>label).click
    sleep 1 if $browser_type == :ie10
  end

  def selected_view_tab
    view_tab_element.div_element(:class=>'dijitTabChecked').text
  end
  
  #Workbench
  # def select_workbench_button(label)
    # workbench_element.span_elements(:class=>'textLabelSpan').select {|s| 
       # s.text =~ /#{Regexp.escape label}/ || s.attribute_value("actionid") == label
    # }.first.parent.parent.click
  # end
# 
  # def workbench_go_back
    # workbench_element.div_element(:class=>'workbenchBackArrow').click
  # end
#   
  # def workbench_previous
    # workbench_element.div_element(:class=>'previousPageTitle')
  # end
#   
  # def workbench_title
    # workbench_element.div_element(:class=>'workbenchTitle').text
  # end
  
  #Generic toolbar.
  def toolbar_button(toolbar, title)
    toolbar.span_elements(:class=>'dijitButtonContents').visible_only.select{|b| b.title==title}[0] ||
    toolbar.div_elements(:class=>'dijitButtonContents').visible_only.select{|b| b.title==title}[0] ||
    toolbar.span_elements(:class=>'dijitButtonText').visible_only.select{|b| b.text==title}[0] || begin
      dropdown = toolbar.div_element(:class => 'xwtToolbarContainerOverflowButton').span_element(:class=>'dijitButtonNode')
      if dropdown.visible?
        dropdown.click
        self.popup_element.cell_elements(:class=>'dijitMenuItemLabel').visible_only.select{|i| i.text == title}[0]
      else
        nil
      end
    end
  end
  alias_method :toolbar_icon, :toolbar_button
  alias_method :toolbar_link, :toolbar_button
  
  def toolbar_buttons(toolbar)
    dropdown = toolbar.div_element(:class => 'xwtToolbarContainerOverflowButton').span_element(:class=>'dijitButtonNode')
    dropdown_items = {}
    if dropdown.visible?
      dropdown.click
      dropdown_items = self.popup_element.cell_elements(:class=>'dijitMenuItemLabel').visible_only.collect{|i| i.text} 
    end
    [
      toolbar.span_elements(:class=>'dijitButtonContents').visible_only.collect{|b| b.title}, 
      toolbar.div_elements(:class=>'dijitButtonContents').visible_only.collect{|b| b.title},
      toolbar.span_elements(:class=>'dijitButtonText').visible_only.collect{|b| b.text},
      dropdown_items
    ].flatten
  end
  alias_method :toolbar_icons, :toolbar_buttons
  alias_method :toolbar_links, :toolbar_buttons
  
end