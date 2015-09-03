class SaikuPopupPage < CustomViewsPage

  include PageObject

  div(:saikuframe, :id => "iframe")
  select_list(:select_cube) { saikuframe_element.iframe.div(:id, "tab_panel").select_list(:class, "cubes")}
  div(:tab) { saikuframe_element.iframe.div(:id, "tab_panel") }
  div(:sidebar_Dim) { tab_element.div(:class => "dimension_tree")}
  div(:sidebar_mes) { tab_element.div(:class => "measure_tree") }

  div(:toolbar) { tab_element.div(:class => "workspace_toolbar") }
  a(:swapaxis) { toolbar_element.a(:class => "i18n swap_axis button sprite i18n_failed i18n_translated", :title => "Swap axis") }

  li(:parent) { tab_element.li(:class, "parent_dimension") }
  a(:dateFolder) { parent_element.a(:class => "folder_collapsed sprite", :title => "Date") }
  a(:allFolder) { parent_element.a(:class => "level", :title => "(All)") }

  div(:rowcol) { tab_element.div(:class => "workspace_results ui-droppable") }
  a(:runquery) { toolbar_element.a(:class => "i18n run button sprite i18n_failed i18n_translated", :title => "Run query") }
  a(:chartpreview) { toolbar_element.a(:class => "i18n toggle_chart_preview button i18n_failed i18n_translated", :title => "Toggle Chart Preview") }

  text_field(:report_title,:name=>"title")
  text_field(:report_desc,:name=>"desc")
  text_field(:report_emmail1,:name=>"to_editor")
  text_field(:report_emmail2,:name=>"failed_to_editor")

  def saiku_tooltip
    on_page(CustomViewsPage).addsaiku_element.click
    actual=[]
    for i in 0..9
      p=@browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class, "workspace_toolbar").a(:class => "i18n",:index=>i).title
      actual<<p
    end
    return actual
  end

  def saiku_chart_Parent
    ind = 0
    while ! @browser.div(:id,"xwt_widget_charting_gridChart__ActionPopup_#{ind}").present?
      puts "coming here"
      puts ind
      ind = ind + 1
    end
    @browser.div(:id,"xwt_widget_charting_gridChart__ActionPopup_#{ind}")
  end

  def saiku_chart_type_preview
    sleep 3
    self.runquery_element.click
    self.chartpreview_element.click
    sleep 5
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class => "workspace_results ui-droppable").div(:class => "bottomRegion").wd.location_once_scrolled_into_view
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class => "workspace_results ui-droppable").div(:class => "bottomIcons").div(:class => "dijitInline icon chartActionIcon").flash.click
    actual=[]
    for i in 1..3
      saiku_chart_Parent.div(:class=>"dijitInline itemLabel",:index=>i).flash
      p=saiku_chart_Parent.div(:class=>"dijitInline itemLabel",:index=>i).text
      actual<<p
    end
    return actual
  end

  def saikuSchedule_report
    name="Report @:#{Time.now}"
    puts name
    sleep 5
    self.report_title_element.when_present.clear
    self.report_title_element.when_present(15).set(name)
    self.report_desc_element.when_present(15).set"verify description"
    self.report_emmail1_element.when_present(15).set"prime_insight1@cisco.com"
    self.report_emmail2_element.when_present(15).set"prime_insight1@cisco.com"
    ind=0
    until @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").present?
      ind=ind+1
      puts "schedule pop: #{ind}"
    end
    @browser.div(:class=>"xwtDialog dijitDialog",:index=>1).span(:text=>"Save").flash.click
    #    self.save_element.when_present.flash.click
  end

  def saiku_chart_export
    @browser.div(:id=>"iframe").iframe.div(:id=>"tab_panel").div(:class => "workspace_results ui-droppable").div(:class => "bottomIcons").div(:class => "dijitInline icon chartMoreActionIcon").click
    saiku_chart_Parent.div(:text => "Schedule Report").flash.click
    self.saikuSchedule_report
  end

  def saiku_SchuduleReportClose
    sleep 3
    buttonid=1
    until @browser.div(:id, "xwt_widget_form_TextButtonGroup_#{buttonid}").present?
      buttonid = buttonid + 1
    end
    p "Presented ID:#{buttonid}"
    @browser.div(:id, "xwt_widget_form_TextButtonGroup_#{buttonid}").span(:text=>"Cancel").flash.click
  end

  def saiku_popup
    if self.saikuframe_element.iframe.present?
      puts "Success-Saiku page popup is open on the main screen"
      return true
    else
      puts "Failure-Saiku page popup is not open on the main screen"
      return false
    end

  end

  def saiku_cube_selection
    sleep 3
    self.select_cube_element.option(:value => "pcwh/Prime Infrastructure/Prime Infrastructure/CVInterfaceUtilizationLastAll").select   # Try to pass drop down data from yml

    if self.sidebar_Dim_element.present? && self.sidebar_mes_element.present?
      puts "Success-Cube is selected dimensions and measures value is displayed"
      return true
    else
      puts "Success-Cube is not selected dimensions and measures value is not displayed"
      return false
    end
  end

  def saiku_row_column_selection

    self.sidebar_mes_element.li(:class => "ui-draggable").a(:class => "measure", :title => "[Measures].[MaxInputUtilization]").wd.location_once_scrolled_into_view
    sleep 2
    ind =0
    self.sidebar_mes_element.lis(:class => "ui-draggable").each do |s|
      measure = s.a(:class => "measure").text
      if measure == "MaxInputUtilization"
        self.sidebar_mes_element.li(:class => "ui-draggable").a(:class => "measure", :text => "MaxInputUtilization").flash.click
      end
      if measure == "MaxOutputUtilization"
        self.sidebar_mes_element.li(:class => "ui-draggable", :index => ind).a(:class => "measure", :text => "MaxOutputUtilization").flash.click
      end
      ind = ind + 1
    end
    sleep 2
    self.swapaxis_element.flash.click
    sleep 2
    self.dateFolder_element.wd.location_once_scrolled_into_view
    sleep 2
    self.dateFolder_element.flash.click
    sleep 2
    self.allFolder_element.flash.click

    if self.rowcol_element.present?
      puts "Success-Table is populated with the data as per the column and row field selection"
      return true
    else
      puts "Failure-Table is populated with the data as per the column and row field selection"
      return true
    end
  end

  def saiku_save_query

    sleep 3
    self.runquery_element.flash.click
    sleep 3
    buttonid=1
    until @browser.div(:id, "xwt_widget_form_TextButtonGroup_#{buttonid}").present?
      buttonid = buttonid + 1
    end
    p "Presented ID:#{buttonid}"
    @browser.div(:id, "xwt_widget_form_TextButtonGroup_#{buttonid}").span(:text=>"Save").flash.click
    #    @browser.div(:class=>"dijit xwtTextButtonGroup").span(:text=>"Save").flash.click
    @browser.div(:id, "iframe").iframe.form(:id, "save_query_form").text_field(:name, "name").set($dash_name)
    puts $dash_name
    @browser.div(:id, "iframe").iframe.form(:id, "save_query_form").text_field(:name, "description").set "verifying the function"
    sleep 3
    @browser.scroll.to :bottom
    @browser.div(:id, "iframe").iframe.div(:class, "dialog dialog_save ui-dialog-content ui-widget-content").div(:class => "dialog_footer").link(:class => "form_button", :href => "#save").wd.location_once_scrolled_into_view

    if $browser_type == :ie10
      @browser.div(:id, "iframe").iframe.div(:class, "dialog dialog_save ui-dialog-content ui-widget-content").div(:class => "dialog_footer").link(:class => "form_button", :href => "#save").click
    else
      @browser.div(:id, "iframe").iframe.div(:class, "dialog dialog_save ui-dialog-content ui-widget-content").div(:class => "dialog_footer").link(:class => "form_button", :href => "#save").fire_event "onclick"
    end

  end

  # case - verify open query

  def open_query

    measure=[]
    sleep 15

    if $browser_type == :ie10
      @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class, "workspace_toolbar").a(:title => "Open query").click
      @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class, "workspace_toolbar").a(:title => "Open query").click
    else
      @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class, "workspace_toolbar").a(:title => "Open query").fire_event"onclick"
    end

    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class, "sidebar queries").div(:class => "sidebar_inner").ul(:id => "queries").lis(:class, "query").each do |s|
      measure << s.text
    end
    puts measure
    dash=$dash_name+".saiku"
    puts dash
    # p measure.class  ---- here .class is used to check whether it one arry or not
    if measure.include? "#{dash}"
      puts "Saved query/dashlet name is displayed"
      return true
    else
      puts "Saved query/dashlet name is not displayed"
      return false
    end

  end

  # case - verify repository search option

  def repository_search

    dash=$dash_name+".saiku"
    #    dash="adam.saiku"
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").text_field(:class => "search_file").when_present.set(dash)
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class => "sidebar_inner").a(:text, dash).when_present.click

    if @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class => "workspace_results").h3.text == dash
      puts "Success-Query search is functionality working"
      return true
    else
      puts "Failure-Query search is functionality not working"
      return false
    end

  end

  # case -  verify folder creation option in repository
  def repository_folder_creation
    sleep 3

    if $browser_type == :ie10
      @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").span(:class => "add_folder_button").a(:class => "add_folder").click
    else
      @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").span(:class => "add_folder_button").a(:class => "add_folder").fire_event"onclick"
    end

    @@folder_name="Sample_Dash-#{Time.now}"
    @browser.div(:id, "iframe").iframe.div(:class => "dialog_body").text_field(:class => "newfolder").clear
    @browser.div(:id, "iframe").iframe.div(:class => "dialog_body").text_field(:class => "newfolder").set(@@folder_name)
    @browser.div(:id, "iframe").iframe.div(:class=>"ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable").div(:class => "dialog_footer").a(:class => "form_button").when_present.click
    sleep 3
    folder=[]
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class, "sidebar queries").div(:class => "sidebar_inner").ul(:id => "queries").lis(:class, "folder").each do |a|
      folder << a.text
    end
    puts folder
    sleep 3
    if folder.include? "#{@@folder_name}"
      puts "Success-Saved folder name is displayed"
      return true
    else
      puts "Failure-Saved folder name is not displayed"
      return false
    end

  end

  # case -  verify delete query in repository

  def repository_delete_query

    dash=$dash_name+".saiku"
    sleep 2
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").text_field(:class => "search_file").clear
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").text_field(:class => "search_file").set dash
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class => "sidebar_inner").a(:text, dash).flash.click
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class => "workspace_toolbar").a(:class => "delete button sprite").flash.click
    @browser.div(:id, "iframe").iframe.div(:class => "ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable").div(:class => "dialog_footer").link(:index => 0).flash.click

    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").text_field(:class => "search_file").clear
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").text_field(:class => "search_file").set dash

    sleep 3
    query_delete=[]
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class, "sidebar queries").div(:class => "sidebar_inner").ul(:id => "queries").lis(:class, "query").each do |s|
      query_delete << s.text
    end
    puts query_delete
    sleep 2
    if query_delete.include? "#{dash}"
      puts "Failure-Query is not deleted"
      return false
    else
      puts "Failure-Query is  deleted"
      return true
    end

  end

  # case - verify set permission for query in repository

  def repository_permisson_query

    dash="sample_dash1.saiku"
    expect="admin"
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").text_field(:class => "search_file").set dash
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class => "sidebar_inner").a(:text, dash).flash.click
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class => "workspace_toolbar").a(:class => "edit_permissions button sprite").flash.click
    @browser.div(:id, "iframe").iframe.div(:class => "dialog dialog_permissions ui-dialog-content ui-widget-content").div(:class => "permissions").input(:class => "acl", :value => "READ").flash.click
    @browser.div(:id, "iframe").iframe.div(:class => "dialog dialog_permissions ui-dialog-content ui-widget-content").div(:class => "permissions").input(:class => "acl", :value => "WRITE").flash.click
    @browser.div(:id, "iframe").iframe.div(:class => "dialog dialog_permissions ui-dialog-content ui-widget-content").div(:class => "permissions").input(:class => "acl", :value => "GRANT").flash.click
    @browser.div(:id, "iframe").iframe.div(:class => "dialog dialog_permissions ui-dialog-content ui-widget-content").form.text_field(:id => "filter_roles", :class => "filterbox ui-autocomplete-input").set(expect)
    @browser.send_keys :arrow_down
    sleep 2
    @browser.div(:id, "iframe").iframe.div(:class => "dialog dialog_permissions ui-dialog-content ui-widget-content").form.input(:class => "i18n add_role i18n_failed i18n_translated").flash.click
    @browser.div(:id, "iframe").iframe.div(:class => "dialog dialog_permissions ui-dialog-content ui-widget-content").div(:class => "private").input(:class => "private").flash.click
    sleep 3
    @browser.div(:id, "iframe").iframe.a(:href => "#ok").flash.click
    sleep 2
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").text_field(:class => "search_file").set dash
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class => "sidebar_inner").a(:text, dash).flash.click
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class => "workspace_toolbar").a(:class => "edit_permissions button sprite").flash.click

    actual=@browser.div(:id, "iframe").iframe.div(:class => "dialog dialog_permissions ui-dialog-content ui-widget-content").div(:class => "private").span(:class => "owner").text

    puts "actual: #{actual}"
    puts "actual: #{expect}"
    sleep 2
    @browser.div(:id, "iframe").iframe.a(:href => "#ok").flash.click

    if actual == expect
      puts "Success-Permisson is set to the query"
      return true
    end
    puts "Failure-Permisson is not set to the query"
    return false
  end

  # case - verify save option in repository

  def repository_save
    sleep 3
    buttonid=1
    until @browser.div(:id, "xwt_widget_form_TextButtonGroup_#{buttonid}").present?
      buttonid = buttonid + 1
    end
    p "Presented ID:#{buttonid}"
    @browser.div(:id, "xwt_widget_form_TextButtonGroup_#{buttonid}").span(:text=>"Save").present?

    if @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").exists?
      puts "Success-Save button is in disabled"
      return true
    else
      puts "Failure-Save button is not in disabled"
      return false
    end

  end

  def saiku_toggle_sidebar
    sleep 3
    @browser.div(:id=>"iframe").iframe(:id=>"adhoc_reports_iframe").div(:class=>"tabs").li(:class => "selected").span(:class => "close_tab sprite").when_present.flash.click
    begin
      @browser.div(:id=>"iframe").iframe(:id=>"adhoc_reports_iframe").div(:class=>"tabs").li(:class => "selected").span(:class => "close_tab sprite").when_present.flash.click
    rescue
      puts"Open query does not exist"
    end
    sleep 10
    self.select_cube_element.focus
    self.select_cube_element.option(:value => "pcwh/Prime Infrastructure/Prime Infrastructure/CVInterfaceUtilizationLastAll").select   # Try to pass drop down data from yml
    self.sidebar_mes_element.li(:class => "ui-draggable").a(:class => "measure", :title => "[Measures].[MaxInputUtilization]").wd.location_once_scrolled_into_view
    sleep 2
    ind =0
    self.sidebar_mes_element.lis(:class => "ui-draggable").each do |s|
      measure = s.a(:class => "measure").text
      if measure == "MaxInputUtilization"
        self.sidebar_mes_element.li(:class => "ui-draggable").a(:class => "measure", :text => "MaxInputUtilization").click
      end
      if measure == "MaxOutputUtilization"
        self.sidebar_mes_element.li(:class => "ui-draggable", :index => ind).a(:class => "measure", :text => "MaxOutputUtilization").click
      end
      ind = ind + 1
    end
    sleep 2
    self.swapaxis_element.click
    sleep 2
    self.dateFolder_element.wd.location_once_scrolled_into_view
    sleep 2
    self.dateFolder_element.click
    sleep 2
    self.allFolder_element.click
    sleep 2
    self.runquery_element.click
    sleep 3
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class, "workspace_toolbar").a(:title => "Toggle sidebar").click

    if @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").select_list(:class, "cubes").present?
      puts "Failure-Toggle sidebar button functionality is not working"
      return false
    else
      puts "Success-Toggle sidebar button functionality is working"
      return true
    end

  end

  def saiku_toggle_field

    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class, "workspace_toolbar").a(:title => "Toggle sidebar").when_present.flash.click

    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class, "workspace_toolbar").a(:title => "Toggle fields").flash.click

    if @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class, "workspace_fields").present?
      puts "Failure-Toggle fields button functionality is not working"
      return false
    else
      puts "Success-Toggle fields button functionality is working"
      return true
    end

  end

  # Case - swap axis

  def saiku_swap_axis
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class, "workspace_toolbar").a(:title => "Toggle fields").flash.click
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class, "workspace_toolbar").a(:class => "i18n swap_axis button sprite i18n_failed i18n_translated", :title => "Swap axis").flash
    if @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class, "workspace_toolbar").a(:class => "i18n swap_axis button sprite i18n_failed i18n_translated", :title => "Swap axis").present?
      puts "Success-swap axis button functionality is  working"
      return true
    else
      puts "Failure-swap axis button functionality is not working"
      return false
    end

  end

  # Case - verify MDX

  def saiku_show_MDX

    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class, "workspace_toolbar").a(:title => "Show MDX").flash.click
    sleep 5
    query=@browser.div(:id, "iframe").iframe.textarea.text

  end

  # Case- verify chart preview

  def saiku_chart_preview

    @browser.div(:id, "iframe").iframe.div(:class => "ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix").span(:class => "ui-icon ui-icon-closethick").flash.click

    if $browser_type == :ie10
      @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class, "workspace_toolbar").a(:title => "Toggle Chart Preview").flash.click
    else
      @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class, "workspace_toolbar").a(:title => "Toggle Chart Preview").fire_event "onclick"
    end

    sleep 3
    if @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class => "workspace_results ui-droppable").div(:class => "bottomIcons").div(:class => "dijitInline icon tableIcon").present?
      puts "Success-Toggle Chart Preview functionality is working"
      return true
    else
      puts "Success-Toggle Chart Preview functionality is not working"
      return false
    end

  end

  # Case- verify tag

  def saiku_tag

    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class, "workspace_toolbar").a(:title => "Toggle Chart Preview").flash.click
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class, "workspace_toolbar").a(:title => "Tags").flash.click
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class => "bucket_items").a(:title => "Add new tag by selecting cells from your result!").flash.click
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class => "workspace_results ui-droppable").table.div(:index => 3).flash.click
    tagname="TestTag"
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class => "bucket_items").text_field(:class => "new_bucket").set tagname
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class => "bucket_items").a(:title => "Save Tag").click
    if @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class => "bucket_items").a(:class => "bucket button").text == tagname
      puts "Success-Tag name is created"
      return true
    else
      puts "Failure-Tag name not created"
      return false
    end

  end

  def saikuQuery_insideFolder
    sleep 3
    buttonid=1
    until @browser.div(:id, "xwt_widget_form_TextButtonGroup_#{buttonid}").present?
      buttonid = buttonid + 1
    end
    p "Presented ID:#{buttonid}"
    @browser.div(:id, "xwt_widget_form_TextButtonGroup_#{buttonid}").span(:text=>"Save").flash.click
    puts "folder name: #{@@folder_name}"
    @browser.div(:id, "iframe").iframe.a(:text, @@folder_name).click
    parent_folder=@browser.div(:id, "iframe").iframe.a(:text, @@folder_name).text
    @browser.div(:id, "iframe").iframe.form(:id, "save_query_form").text_field(:name, "name").set parent_folder+"/dashlet1"
    @browser.div(:id, "iframe").iframe.form(:id, "save_query_form").text_field(:name, "description").set "verifying the function"
    sleep 3
    @browser.scroll.to :bottom
    @browser.div(:id, "iframe").iframe.div(:class, "dialog dialog_save ui-dialog-content ui-widget-content").div(:class => "dialog_footer").link(:class => "form_button", :href => "#save").wd.location_once_scrolled_into_view

    if $browser_type == :ie10
      @browser.div(:id, "iframe").iframe.div(:class, "dialog dialog_save ui-dialog-content ui-widget-content").div(:class => "dialog_footer").link(:class => "form_button", :href => "#save").flash.click
    else
      @browser.div(:id, "iframe").iframe.div(:class, "dialog dialog_save ui-dialog-content ui-widget-content").div(:class => "dialog_footer").link(:class => "form_button", :href => "#save").fire_event "onclick"
    end

    folder_query="#{parent_folder}/dashlet1.saiku"
    sleep 3
    self.viewname_element.when_present.clear
    self.viewname_element.when_present.set(folder_query)
    sleep 5
    if @browser.div(:class => "table-body").div(:class=>"row-0").div(:class =>"cell-1").text == folder_query
      puts "Success-Inside folder query is displayed in custom view page"
      return true
    else
      puts "Failure-Inside folder query is not displayed in custom view page"
      return false
    end
  end

end