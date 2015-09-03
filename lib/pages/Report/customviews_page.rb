class CustomViewsPage < AppPage

  #Page object for filter text box
  div(:tableHeader,:class=>"table-header-container filter-by-example")
  div(:filterBox){tableHeader_element.div_element(:class=>/xwtFilterByExample/)}
  text_field(:viewname){filterBox_element.div_element(:class=>"cell-1").text_field(:class=>"dijitInputInner")}
  text_field(:discription){filterBox_element.div_element(:class=>"cell-2").text_field(:class=>"dijitInputInner")}
  div(:customViewrow1QuickView){div_element(:class=>"table-container").div_element(:class=>"row-0").span(:class=>"xwtPopoverHintHover pOverCell-1")}
  div(:os, :id=>"objSelectorId")
  div(:thetable, :id=>'theTable')
  div(:pagetitle,:class=>'xwtOsTitlebarLeft')
  span(:addsaiku,:id=>'launchSaiku')
  div(:customviewtable, :class=>"table-container")

  #Page object for Quick View dijitTooltipDialogPopup
  div(:dijitPopup,:class=>"dijitPopup dijitTooltipDialogPopup")
  div(:chartMode,:title=>"Chart Mode")
  div(:gridMode,:title=>"Grid Mode")
  div(:chartTypes,:title=>"Chart Types")
  div(:exportView,:title=>"Export")
  div(:quickViewClose,:class=>"xwtPopoverClose icon-close xwtPopoverButton")
  div(:chartNode,:class=>"chartNode")
  div(:gridNode,:class=>"gridNode")

  #Page object for saiku
  div(:saiku_frame, :id => "iframe")
  select_list(:select_cube) { saiku_frame_element.iframe.div(:id, "tab_panel").select_list(:class, "cubes")}
  div(:tab) { saiku_frame_element.iframe.div(:id, "tab_panel") }
  div(:sidebar_Dim) { tab_element.div(:class => "dimension_tree")}
  div(:sidebar_mes) { tab_element.div(:class => "measure_tree") }
  div(:toolbar) { tab_element.div(:class => "workspace_toolbar") }
  a(:swapaxis) { toolbar_element.a(:class => "i18n swap_axis button sprite i18n_failed i18n_translated", :title => "Swap axis") }
  li(:parent) { tab_element.li(:class, "parent_dimension") }
  a(:dateFolder) { parent_element.a(:class => "folder_collapsed sprite", :title => "Date") }
  a(:allFolder) { parent_element.a(:class => "level", :title => "(All)") }
  div(:rowcol) { tab_element.div(:class => "workspace_results ui-droppable") }
  a(:runquery) { toolbar_element.a(:class => "i18n run button sprite i18n_failed i18n_translated", :title => "Run query") }

  #Page object for quickview window
  div(:qvpopupID,:class=>"xwtPopover dijitTooltipDialog dijitTooltipABRight dijitTooltipLeft")
  div(:chartTooltip){qvpopupID_element.div(:id=>qvpopupID_element.id).div(:class=>"chartNode").element(:css => "svg").elements(:css => "rect")}

  #Page object for chart
  div(:tooltipHeader,:id =>"xwt_widget_charting_widget__MasterDatatip_0")
  div(:tooltipValue){tooltipHeader_element.div(:class =>"dijitTooltipContainer dijitTooltipContents")}

  #  span(:saiku_save, :class=>'dijitButtonNode', :text=>/Save/)
  #  text_field(:text_input,:class=>"dijitReset dijitInputInner dijitDownArrowButton")
  #  checkbox(:select_click,:class=>"selection-input")

  def goto
    navigate_application_to "Report=>Custom Views"
  end

  #  def loaded?(*how)
  #    os_loaded?(os_element) &&
  #    view_content_loaded?(thetable_element)
  #  end
  def loaded?(*how)
    pageTitle_element.present?
  end

  def homeDashlet_Data

    dashletNames=["sample_dash1","sample_dash2","sample_dash3"]
    dashletNames.each do |dashletName|
      self.addsaiku_element.when_present.click
      sleep 10
      self.select_cube_element.option(:value => "pcwh/Prime Infrastructure/Prime Infrastructure/CVInterfaceUtilizationLastAll").select
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
      sleep 3
      self.runquery_element.flash.click
      buttonid = 1
      until @browser.div(:id, "xwt_widget_form_TextButtonGroup_#{buttonid}").present?
        buttonid = buttonid + 1
      end
      p buttonid
      @browser.div(:id, "xwt_widget_form_TextButtonGroup_#{buttonid}").span(:text, "Save").flash.click
      @browser.div(:id, "iframe").iframe.form(:id, "save_query_form").text_field(:name, "name").set(dashletName)
      @browser.div(:id, "iframe").iframe.form(:id, "save_query_form").text_field(:name, "description").set "verifying the function"
      sleep 3
      @browser.scroll.to :bottom
      @browser.div(:id, "iframe").iframe.div(:class, "dialog dialog_save ui-dialog-content ui-widget-content").div(:class => "dialog_footer").link(:class => "form_button", :href => "#save").wd.location_once_scrolled_into_view
      if $browser_type == :ie10
        @browser.div(:id, "iframe").iframe.div(:class, "dialog dialog_save ui-dialog-content ui-widget-content").div(:class => "dialog_footer").link(:class => "form_button", :href => "#save").flash.click
      else
        @browser.div(:id, "iframe").iframe.div(:class, "dialog dialog_save ui-dialog-content ui-widget-content").div(:class => "dialog_footer").link(:class => "form_button", :href => "#save").fire_event "onclick"
      end
    end
  end

  def customview_quickview
    @browser.span(:class=>"xwtPopoverHintHoverIcon xwtPopupIcon").flash.click
    sleep 5
    poupID=@browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABRight dijitTooltipLeft").id
    puts "popUPID: #{poupID}"
    all= @browser.div(:id,"#{poupID}").div(:class,"chartNode").elements(:css => "svg")
    chartelement=[]
    all.each do |p|
      p.when_present.click
      p.fire_event("onmousehour")
      chartelement<<tooltipValue_element.text
    end
    puts "ChartTool Tip Value: #{chartelement}"
    @browser.div(:class=>"xwtPopoverClose icon-close xwtPopoverButton").flash.click
    return chartelement
  end

  def saiku_open_query
    sleep 3
    self.viewname_element.when_present.set($dash_name)
    if @browser.div(:class=>"table-body").div(:class=>"cell-1").text == $dash_name
      puts"Success-Query is displayed in custom view page"
      return true
    else
      puts"Success-Query is displayed in custom view page"
      return true
    end
  end

  def saiku_delete_query
    self.viewname_element.when_present.clear
    self.discription_element.when_present.clear
    self.viewname_element.when_present.set($dash_name)
    sleep 3
    @browser.checkbox(:class=>"selection-input").set
    @browser.div(:class=>"xwtRibbonWrapper").span(:class=>"dijitReset dijitInline dijitIcon xwtContextualIcon xwtContextualDelete").flash.click
    sleep 5
    @browser.span(:class=>"dijitButtonText",:text=>"OK").when_present.click
    actual=@browser.div(:class=>"no-results").text
    if  actual == "No data available"
      return true
    else
      return false
    end
  end

  def customview_setting
    sleep 5
    @browser.div(:class=>"xwtGlobalToolbarActions").span(:class=>"dijitReset dijitStretch dijitButtonContents dijitDownArrowButton").when_present.flash.click
    sleep 10
    @browser.td(:id=>"[Widget xwt.widget.table.Table, xwt_widget_table_Table_0]_xwtTableGlobalToolbar_columnsMenu_text").when_present.flash.click
    if @browser.div(:id=>"[Widget xwt.widget.table.Table, xwt_widget_table_Table_0]_xwtTableGlobalToolbar_columnsMenu_dropdown").exists?
      puts "Success-Setting icon is display column dropdown and Fix Row"
      return true
    else
      puts "Success-Setting icon is not display column dropdown and Fix Row"
      return false
    end
  end

  def customview_filter
    @browser.div(:class=>"xwtGlobalToolbarActions").span(:class=>"dijitReset dijitStretch dijitButtonContents dijitDownArrowButton").when_present.flash.click
    sleep 10
    @browser.table(:class=>"xwtContextualToolbarRibbonContainer").div(:class=>"xwtQuickFilter").div(:class=>"dijitReset dijitRight dijitButtonNode dijitArrowButton dijitDownArrowButton dijitArrowButtonContainer icon-triangle icon-rotate-90").when_present.click
    #  if @browser.div(:id=>"widget_[Widget xwt.widget.table.Table, xwt_widget_table_Table_0]_xwtTableContextualToolbar_quickFilterSelect_dropdown").exists?
    if @browser.div(:class=>"dijitPopup dijitMenuPopup").exists?
      puts"Success-Filter functionality is working"
      return true
    else
      puts"Failure-Filter functionality is not working"
      return false
    end
  end

  def customview_recordcount
    self.viewname_element.when_present.set($dash_name)
    #    self.viewname_element.when_present.set("adam.saiku")
    @browser.checkbox(:class=>"selection-input").click
    total_query_count=@browser.div(:class=>"xwtGlobalToolbarActions").span(:class=>"totalCountLabel").text
    puts "Total_Query #{total_query_count}"
    row_select="Selected 1"
    sleep 10
    if @browser.div(:class=>"xwtGlobalToolbarActions").span(:class=>"selectionCountLabel").text == row_select
      puts"Success-verify record count is working"
      return true
    else
      puts"Success-verify record count is not working"
      return false
    end
  end

  def scheduleReport_customData

    dashlets=["schedule_dash1", "schedule_dash2"]
    dashlets.each do |dashlet|
      self.addsaiku_element.when_present.click
      sleep 5
      self.select_cube_element.option(:value => "pcwh/Prime Infrastructure/Prime Infrastructure/CVInterfaceUtilizationLastAll").select
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
      sleep 3
      self.runquery_element.flash.click
      buttid = 1

      until @browser.div(:id, "xwt_widget_form_TextButtonGroup_#{buttid}").present?
        p "get into UNTIL"
        buttid = buttid + 1
      end
      p buttid
      @browser.div(:id, "xwt_widget_form_TextButtonGroup_#{buttid}").span(:text, "Save").when_present.flash.click
      @browser.div(:id, "iframe").iframe.form(:id, "save_query_form").text_field(:name, "name").set(dashlet)
      puts $dash_name
      @browser.div(:id, "iframe").iframe.form(:id, "save_query_form").text_field(:name, "description").set "verifying the function"
      sleep 3
      @browser.scroll.to :bottom
      @browser.div(:id, "iframe").iframe.div(:class, "dialog dialog_save ui-dialog-content ui-widget-content").div(:class => "dialog_footer").link(:class => "form_button", :href => "#save").wd.location_once_scrolled_into_view
      if $browser_type == :ie10
        @browser.div(:id, "iframe").iframe.div(:class, "dialog dialog_save ui-dialog-content ui-widget-content").div(:class => "dialog_footer").link(:class => "form_button", :href => "#save").flash.click
      else
        @browser.div(:id, "iframe").iframe.div(:class, "dialog dialog_save ui-dialog-content ui-widget-content").div(:class => "dialog_footer").link(:class => "form_button", :href => "#save").fire_event "onclick"
      end
    end
  end

  def customQuickView_scheduleReport
    @browser.div(:class=>"bottomRegion").div(:class=>"bottomIcons").flash
    @browser.div(:class=>"bottomRegion").div(:class=>"bottomIcons").div(:title=>"Export").when_present.flash.click
    smallpop = @browser.div(:class,"dijitPopup Popup").id
    @browser.div(:id,"#{smallpop}").div(:text=>"Schedule Report").when_present.flash.click
    ind=0
    until @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").present?
      puts ind
      ind = ind + 1
    end
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").flash
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").text_field(:name=>"title").set("interface Report:#{Time.now}")
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").span(:text=>"Save").when_present.flash.click
  end

  def customQuickView_ExportCSVFormet
    #  sleep 5
    @browser.div(:class=>"bottomIcons").div(:title=>"Export").when_present.flash.click
    ind = 0
    until @browser.div(:id,"popup_#{ind}").present?
      puts ind
      ind = ind + 1
    end
    @browser.div(:id,"popup_#{ind}").div(:class=>"dijitInline itemLabel",:text=>"Export").when_present.flash.click

    ind=0
    until @browser.div(:id=>"xwt_widget_form_TextButtonGroup_#{ind}").present?
      puts ind
      ind = ind + 1
    end
    @browser.div(:id=>"xwt_widget_form_TextButtonGroup_#{ind}").span(:text=>"Export").when_present.flash.click
    sleep 15
    last_csv_file = on_page(GlobalPage).get_last_created($download_directory)
    puts "Last CSV File Path:",last_csv_file.path
    csv_file = File.read(last_csv_file)
    csv_data = CSV.parse(csv_file)
    csv_values = Array.new
    csv_data.each do  |row|
      puts row.inspect
      csv_values << row
    end
    return csv_values
    #    csv_values.slice!(0,3)
    #    csv_main = csv_values.reject!(&:empty?)
    #    puts "Final CSV data: #{csv_main}"
  end

  def customquickview_date
    #  sleep 3
    chartTimestamp=@browser.div(:class=>"bottomIcons").text
    actual=chartTimestamp[0..11]
    return actual
  end
end
