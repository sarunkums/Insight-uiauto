class ErrorsandDiscardsPage < AppPage  # 17-06-15- Changed the Page name "AppPage" into "GenericDashboardPage"

  #Page objects for global fiter
  div(:global_toolbar, :class=>'xwtGlobalToolbar')
  div(:filter,:class=>"dashboardFilter")
  div(:cb, :id=>'widget_emsam_application_advancereports_globalfilters_IntervalFilter_1')
  span(:ok_a,:text=>"OK",:index=>0)
  span(:ok_b,:text=>"OK",:index=>1)

  #Page objects for error and discards settings
  div(:dijitPopup,:class=>"dijitPopup dijitMenuPopup")
  td(:column){dijitPopup_element.td(:class=>"dijitReset dijitMenuItemLabel")}
  div(:columnsContainer,:class=>"columnsContainerDiv")
  td(:in_errors){columnsContainer_element.td(:text=>"95% Util in (95 Percentile Input Utilization)")}
  span(:close,:class=>"dijitReset dijitInline dijitButtonText",:text=>"Close")
  span(:reset,:class=>"dijitReset dijitInline dijitButtonText",:text=>"Reset")

  #Page objects for error and discards table
  div(:errorChartBottom,:class=>"bottomRegion")
  div(:tableHeader,:class=>"table-head-node-container")
  div(:column_add){tableHeader_element.div(:text=>"95% Util in")}
  div(:filterBox){tableHeader_element.div(:class=>"xwtFilterByExample")}

  #Page object for filter text box
  div(:filterMenuPopup,:class=>"dijitPopup dijitMenuPopup")

  text_field(:filterInterfacename){filterBox_element.div(:class=>"cell-0").text_field(:class=>"dijitInputInner")}
  text_field(:filterDevicename){filterBox_element.div(:class=>/cell-1/).text_field(:class=>/dijitInputInner/)}
  text_field(:filterLocation){filterBox_element.div(:class=>/cell-2/).text_field(:class=>/dijitInputInner/)}
  text_field(:filterInterfacegroup){filterBox_element.div(:class=>/cell-3/).text_field(:class=>/dijitInputInner/)}
  text_field(:filterLinkspeed){filterBox_element.div(:class=>/cell-4/).text_field(:class=>/dijitInputInner/)}

  #Page object for chart
  div(:tooltipHeader,:id =>"xwt_widget_charting_widget__MasterDatatip_0")
  div(:tooltipValue){tooltipHeader_element.div(:class =>"dijitTooltipContainer dijitTooltipContents")}

  #Page objects for schedule reports pop up

  div(:popup,:class=>"xwtDialog dijitDialog")
  div(:contentPane){popup_element.div(:class=>"dijitContentPane")}
  div(:format_a){popup_element.tr(:index=>0).td(:index=>1)}
  div(:format_b){popup_element.tr(:index=>1)}

  text_field(:report_title,:name=>"title")
  text_field(:report_desc,:name=>"desc")
  text_field(:report_emmail1,:name=>"to_editor")
  text_field(:report_emmail2,:name=>"failed_to_editor")

  radio(:csv,:id=>"csvRadio")
  radio(:pdf,:id=>"pdfRadio")
  div(:startdate){popup_element.div(:class=>"calendarIcon",:index=>0)}
  div(:enddate){popup_element.div(:class=>"calendarIcon",:index=>1)}
  text_field(:enddateTextBox,:id=>/XwtDateTextBox/,:index=>1)
  radio(:endDateratio,:id=>/endDateRadio/)
  table(:calendarbody,:class=>/dijitCalendarContainer/)

  span(:save){popup_element.span(:text=>"Save")}
  span(:cancel){popup_element.span(:text=>"Cancel")}

  #Page object for Interface Detail View
  
  div(:dateLink,:class=>"dijitInline actionItem")
  div(:datePopUp,:class=>"dijitTooltipDialogPopup")
  span(:datePopUpTitle){datePopUp_element.span(:class=>"xwtPopoverTitle")}
  div(:datePopUpClose){datePopUp_element.div(:class=>"icon-close")}
  radio(:radio_Absolute,:id=>"absoluteMode")
  radio(:radio_Percent,:id=>"percentMode")

  checkbox(:checkinUtil){filterDiv_element.checkbox(:id,"inUtil")}
  checkbox(:checkoutUtil){filterDiv_element.checkbox(:id,"outUtil")}

  radio(:radio_Merged,:id=>"merged")
  radio(:radio_Individual,:id=>"unmerged")

  span(:applyFilter,:id=>"applyBt_label")
  span(:applyCloseFilter,:id=>"applyCloseBt_label")
  span(:resetFilter,:id=>"resetBt_label")

  div(:chartBottom,:class=>"bottomRegion")
  div(:chartLegend,:class=>"chartPanelHorizontalLegend")
  checkbox(:inputBox){chartLegend_element.checkbox(:index=>0)}
  checkbox(:outputBox){chartLegend_element.checkbox(:index=>1)}
  div(:filterDiv,:id=>"filterDiv")
  div(:filterArrow,:id=>"InterfaceMetricFilter_arrowNodeInner")
  #  span(:pageTitle,:class=>"xwtBreadcrumbText xwtBreadcrumbLast")

  #Page objects for SETTINGS

  span(:setting,:text=>"Settings")
  div(:filterMenu,:text=>"Add or Remove Filter(s)")
  div(:duration,:class=>"itemActionNode",:index=>0)
  div(:location,:class=>"itemActionNode",:index=>1)
  div(:interfaceGroup,:class=>"itemActionNode",:index=>2)

  def errorParent
    ind = 0
    while ! @browser.div(:id,"xwt_widget_layout_TabContentPane_#{ind}").present?
      puts ind
      ind = ind + 1
    end
    @browser.div(:id,"xwt_widget_layout_TabContentPane_#{ind}")
  end

  def errordiscard_tab
    sleep 5
    #    duratioDrop=errorParent.div(:class =>"dashboardFilter")
    #    self.open_combobox(duratioDrop)
    errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present(15).flash.click
    if $browser_type == :ie10
      errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end

    actual=[]
    sleep 2
    all=@browser.div(:class=> "dijitReset dijitMenu dijitComboBoxMenu xwtComboBoxPopup").lis(:class=>"dijitReset dijitMenuItem")
    sleep 5
    all.each do |p|
      actual<<p.text
    end
    return actual
  end

  def errordiscards_location
    errorParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>0).when_present.flash.click
    a=@browser.div(:class=>"xwtPopover dijitTooltipDialog xwt_BasePickerPopover dijitTooltipABLeft dijitTooltipBelow",:index=>0).id
    @browser.div(:id=>"#{a}").div(:class=>"dijitTreeContainer").span(:class=>"dijitTreeExpando dijitTreeExpandoClosed").when_present.flash.click
    if @browser.div(:class,"dijitTreeContainer").exists?
      puts "Success-Site group displyed all information"
      return true
    else
      puts"Failure-Site group does not displyed all information"
      return false
    end
  end

  def errordiscards_group
    errorParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.flash.click
    a=@browser.div(:class=>"xwtPopover dijitTooltipDialog xwt_BasePickerPopover dijitTooltipABLeft dijitTooltipBelow",:index=>1).id
    @browser.div(:id=>"#{a}").div(:class=>"dijitTreeContainer").span(:class=>"dijitTreeExpando dijitTreeExpandoClosed").when_present.flash.click
    if @browser.div(:class,"dijitTreeContainer").exists?
      puts "Success-Interface group displyed all information"
      return true
    else
      puts"Failure-Interface group does not displyed all information"
      return false
    end

  end

  def error_global_filter

    errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present(15).flash.click
    if $browser_type == :ie10
      errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    @browser.li(:text=>"Last 2 Weeks").when_present.flash.click # Check how to apply .yml data
    errorParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>0).when_present.flash.click
    sleep 3
    #    self.ok_a_element.when_present.flash.click
    errorParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.click
    sleep 3
    #    self.ok_b_element.when_present.flash.click
    errorParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
  end

  def errordiscard_global_filter

    errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present(15).flash.click
    if $browser_type == :ie10
      errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    @browser.li(:text=>"Last 2 Weeks").when_present.flash.click # Check how to apply .yml data
    errorParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>0).when_present.flash.click
    #    sleep 3
    #    self.ok_a_element.when_present.flash.click
    errorParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.click
    #    sleep 3
    #    self.ok_b_element.when_present.flash.click
    errorParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
  end

  def errors_and_discards_setting

    errorParent.div(:class=>"xwtGlobalToolbarActions").span(:class=>"dijitReset dijitStretch dijitButtonContents dijitDownArrowButton").when_present.flash.click
    #    if $browser_type == :ie10
    #      errorParent.div(:class=>"xwtGlobalToolbarActions").span(:class=>"dijitReset dijitStretch dijitButtonContents dijitDownArrowButton").when_present.flash.click
    #    else
    #      puts"Running Browser is not an IE"
    #    end
    self.column_element.when_present.flash.click
    self.in_errors_element.when_present.flash.click
    self.close_element.when_present.flash.click
    errorParent.table(:class,"table-header").td(:class => /cell-container-5/).flash
    if errorParent.table(:class,"table-header").td(:class => /cell-container-5/).present?
      puts "Success-The new column is added on interface utilization table"
      return true
    else
      puts "Failure-The new column is not added on interface utilization table"
      return false
    end

  end

  def interfacetable_sorting
    sleep 3
    uiall = []
    uiall = errorParent.div(:class=>"table dijitLayoutContainer dijitContainer emsamHiddenBottomLine").div(:class,"table-container").divs(:class,/row noSe/)
    unsorted = []
    uiall.each do |p|
      p.table(:class,"row-table").tr.td(:class => /cell-container/, :index =>7).flash
      unsorted << p.table(:class,"row-table").tr.td(:class => /cell-container/, :index =>7).text.scan(/[0-9#]+/i)
    end
    ascendingsort  = unsorted.sort {|x, y| x <=> y}
    puts "Ascending", ascendingsort
    descendingsort = unsorted.sort! {|x, y| y <=> x}
    puts "Descending", descendingsort
    #     sleep 5
    errorParent.div(:class=>"table dijitLayoutContainer dijitContainer emsamHiddenBottomLine").div(:class,"table-head-node-container").table(:class,"table-header").td(:class => /cell-container-7/).when_present.click
    #     sleep 5
    uiall = errorParent.div(:class=>"table dijitLayoutContainer dijitContainer emsamHiddenBottomLine").div(:class,"table-container").divs(:class,/row noSe/)
    sorted = []
    uiall.each do |p|
      p.table(:class,"row-table").tr.td(:class => /cell-container/, :index =>7).flash
      sorted << p.table(:class,"row-table").tr.td(:class => /cell-container/, :index =>7).text.scan(/[0-9#]+/i)
    end

    if sorted == ascendingsort
      puts "It sorted successfully in ascending"
    else
      if sorted ==  descendingsort
        puts "It sorted successfully in descending"
      else
        puts "There is some problem in sorting"
        return false
      end
    end
    errorParent.table(:class,"table-header").td(:class => /cell-container-7/).when_present.click
    uiall = errorParent.div(:class=>"table dijitLayoutContainer dijitContainer emsamHiddenBottomLine").div(:class,"table-container").divs(:class,/row noSe/)
    sorted = []
    uiall.each do |p|
      p.table(:class,"row-table").tr.td(:class => /cell-container/, :index =>7).flash
      sorted << p.table(:class,"row-table").tr.td(:class => /cell-container/, :index =>7).text.scan(/[0-9#]+/i)
    end
    if sorted == ascendingsort
      puts "It sorted successfully in ascending"
      return true
    else
      if sorted ==  descendingsort
        puts "It sorted successfully in descending"
        return true
      else
        puts "There is some problem in sorting"
        return false
      end
    end
  end

  def  interface_backplane(interfacename)

    interface_name = interfacename
    errorParent.div(:class=>"table-head-node-container").div(:class=>"xwtFilterByExample").div(:class=>"cell-0").text_field(:class=>"dijitInputInner").when_present.set(interface_name)
    sleep 5
    errorParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present(5).flash.click
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").span(:class,"xwtPopoverTitle").flash
    if @browser.div(:id,"#{popid}").span(:class,"xwtPopoverTitle").exists?
      puts "Success-BackPlane option details displayed"
      return true
    else
      puts "Failure-BackPlane option details not displayed"
      return false
    end
  end

  def interface_icons

    interface_name="FastEthernet0/1"
    #    device_name="3560_switch_top.cisco.com"
    sleep 2
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:title=>"Close").when_present.click
    #    sleep 3
    errorParent.div(:class=>"table-head-node-container").div(:class=>/xwtFilterByExample/).div(:class=>/cell-0/).text_field(:class=>/dijitInputInner/).when_present.set(interface_name)
    #    errorParent.div(:class=>"table-head-node-container").div(:class=>/xwtFilterByExample/).div(:class=>/cell-1/).text_field(:class=>/dijitInputInner/).when_present.set(device_name)
    sleep 3
    if errorParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").present?
      sleep 5
      errorParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.click
    else if
      popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
        poptitle = @browser.div(:id,"#{popid}").span(:class,"xwtPopoverTitle").exists?
        puts "Success-Interface icon is displayed"
        return true
      else
        puts "Failure-Interface icon is not displayed"
        return false
      end
    end
  end

  def interface_title

    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:title=>"Close").when_present.flash.click
    sleep 3
    errorParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.click
    sleep 3
    @browser.div(:id,"#{popid}").span(:class,"xwtPopoverTitle").flash
    poptitle = @browser.div(:id,"#{popid}").span(:class,"xwtPopoverTitle").text

  end

  def quickview_footericons
    #    sleep 3
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    actualicon=[]
    @browser.div(:id,"#{popid}").div(:class=>"bottomIcons").flash
    all=@browser.div(:id,"#{popid}").div(:class=>"bottomIcons").divs(:class=>/dijitInline icon/)
    all.each do |a|
      actualicon<<a.title
    end
    return actualicon
  end

  def quickview_date
    #  sleep 3
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    chartTimestamp=@browser.div(:id,"#{popid}").div(:class=>"bottomIcons").text
    actual=chartTimestamp[0..11]
    return actual
  end

  def interfaceChart_onepointTooltip
    sleep 2
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    chartelement = []
    p = @browser.div(:id,"#{popid}").div(:class,"chartNode").element(:css => "svg").element(:css => "polyline") # check with team how to get first tool tip
    sleep 5
    p.when_present.click
    #p.fire_event("onmouseover")
    p.hover
    chartelement << self.tooltipValue_element.text
    puts "Tooltib Value: #{chartelement}"
    return chartelement
  end

  def interfaceChart_allTooltip
    sleep 5
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    chartelement = []
    all = @browser.div(:id,"#{popid}").div(:class,"chartNode").element(:css => "svg").elements(:css => "polyline")
    all.each do |p|
      p.when_present(15).click
      #      p.fire_event("onmouseover")
      p.hover
      chartelement << self.tooltipValue_element.text
      sleep 3
    end
    puts "Tooltib Value Before Uniq: #{chartelement}"
    chartelement_uniq = chartelement.uniq
    puts "Tooltib Value After Uniq: #{chartelement_uniq}"
    return chartelement_uniq
  end

  def interface_Gridmode    ## Regression

    actual=[]
    sleep 5
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"bottomIcons").div(:title=>"Grid Mode").when_present.flash.click
    for i in 0..2
      val=@browser.div(:id,"#{popid}").div(:class,"gridNode").div(:class,"dojoxGridHeader").th(:index=>i).text
      actual<<val
    end
    puts "Here Actual: #{actual}"
    return actual
  end

  def interfaceGrid_sorting

    #      sleep 2
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"bottomIcons").div(:title=>"Grid Mode").when_present.flash.click
    uiall = []
    uiall = @browser.div(:id,"#{popid}").div(:class=>"gridNode").div(:class,"dojoxGridContent").divs(:class,/dojoxGridRow/)
    unsorted = []
    uiall.each do |p|
      p.table(:class,"dojoxGridRowTable").tr.td(:class => /dojoxGridCell/, :index => 1).flash
      unsorted << p.table(:class,"dojoxGridRowTable").tr.td(:class => /dojoxGridCell/, :index => 1).text.scan(/[0-9#]+/i)
    end
    ascendingsort  = unsorted.sort {|x, y| x <=> y}
    puts "Ascending", ascendingsort
    descendingsort = unsorted.sort! {|x, y| y <=> x}
    puts "Descending", descendingsort
    @browser.div(:id,"#{popid}").div(:class=>"gridNode").div(:class=>"dojoxGridMasterHeader").th(:class=>"dojoxGridCell dojoDndItem",:index=>1).when_present.flash.click
    uiall = @browser.div(:id,"#{popid}").div(:class=>"gridNode").div(:class,"dojoxGridContent").divs(:class,/dojoxGridRow/)
    sorted = []
    uiall.each do |p|
      p.table(:class,"dojoxGridRowTable").tr.td(:class => /dojoxGridCell/, :index => 1).flash
      sorted << p.table(:class,"dojoxGridRowTable").tr.td(:class => /dojoxGridCell/, :index => 1).text.scan(/[0-9#]+/i)
    end
    if sorted == ascendingsort
      puts "It sorted successfully in ascending"
    else
      if sorted ==  descendingsort
        puts "It sorted successfully in descending"
      else
        puts "There is some problem in sorting"
        return false
      end
    end
    @browser.div(:id,"#{popid}").div(:class=>"gridNode").div(:class=>"dojoxGridMasterHeader").th(:class=>"dojoxGridCell dojoDndItem",:index=>1).when_present.flash.click
    uiall = @browser.div(:id,"#{popid}").div(:class=>"gridNode").div(:class,"dojoxGridContent").divs(:class,/dojoxGridRow/)
    sorted = []
    uiall.each do |p|
      p.table(:class,"dojoxGridRowTable").tr.td(:class => /dojoxGridCell/, :index => 1).flash
      sorted <<  p.table(:class,"dojoxGridRowTable").tr.td(:class => /dojoxGridCell/, :index => 1).text.scan(/[0-9#]+/i)
    end
    if sorted == ascendingsort
      puts "It sorted successfully in ascending"
      return true
    else
      if sorted ==  descendingsort
        puts "It sorted successfully in descending"
        return true
      else
        puts "There is some problem in sorting"
        return false
      end
    end
  end

  def interfaceGrid_inpututilization
    sleep 5
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"bottomIcons").div(:title=>"Grid Mode").when_present.flash.click
    actual=@browser.div(:id,"#{popid}").div(:class,"gridNode").div(:class,"dojoxGridHeader").th(:index=>1).text
    return actual
  end

  def interfaceGrid_oupututilization
    #  sleep 2
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    actual=@browser.div(:id,"#{popid}").div(:class,"gridNode").div(:class,"dojoxGridHeader").th(:index=>2).text
    return actual
  end

  def interface_exportReport_icon
    #    sleep 2
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    sleep 5
    @browser.div(:id,"#{popid}").div(:class=>"bottomIcons").div(:title=>"Export/Print").when_present.flash.click
    smallpop = @browser.div(:class,"dijitPopup Popup").id
    actual=[]
    all=@browser.div(:id,"#{smallpop}").divs(:class,"actionDropDownItem groupChild nonSelectable")
    all.each do |p|
      actual << p.div(:class,"dijitInline itemLabel").text
    end
    return actual

  end

  def interface_export_format
    #  sleep 5
    smallpop = @browser.div(:class,"dijitPopup Popup").id
    @browser.div(:id,"#{smallpop}").div(:class=>"dijitInline itemLabel",:text=>"Export").when_present.flash.click
    sleep 2
    #    export_popup=@browser.div(:class=>"exportDialog xwtDialog dijitDialog").id
    actual=@browser.div(:class,"xwtChartExportDialogFormat").text
    return actual
  end

  def interface_report_print

    ind=0
    puts"it's going to until loop"
    until @browser.div(:id,"xwt_widget_charting_gridChart_exportPanels_ExportDialog_#{ind}").present?
      ind=ind+1
      puts "Export/Print: #{ind}"
    end

    @browser.div(:id,"xwt_widget_charting_gridChart_exportPanels_ExportDialog_#{ind}").span(:class,"dijitDialogIcon dijitDialogCloseIcon icon-close").when_present.flash.click
    #  sleep 2
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"bottomIcons").div(:title=>"Export/Print").flash
    sleep 5
    @browser.div(:id,"#{popid}").div(:class=>"bottomIcons").div(:title=>"Export/Print").when_present.flash.click
    #  sleep 3
    smallpop = @browser.div(:class,"dijitPopup Popup").id
    @browser.div(:id,"#{smallpop}").div(:class=>"dijitInline itemLabel",:text=>"Print").flash.present?

  end

  def scheduleReport_feature

    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:title=>"Close").when_present.flash.click
    sleep 5
    errorParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.click
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    sleep 3
    @browser.div(:id,"#{popid}").div(:class=>"bottomIcons").div(:title=>"Export/Print").when_present.flash.click

    smallpop = @browser.div(:class,"dijitPopup Popup").id
    sleep 20
    @browser.div(:id,"#{smallpop}").div(:class=>"dijitInline itemLabel",:text=>"Schedule Report").when_present.flash.click
    sleep 3
    if self.contentPane_element.present?
      puts "Success-Schedule Report display all features"
      return true
    else
      puts "Failure-Schedule Report does not display all features"
      return false
    end
  end

  def scheduleReport_format

    #  sleep 2
    actual=["CSV"]

    ind=0
    until @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").present?
      ind=ind+1
      puts "schedule pop: #{ind}"
    end
    actual<<@browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").tr(:index=>1).text
    #    actual<<self.format_a_element.text
    #    actual<<self.format_b_element.text
    return actual

  end

  def schedule_report
    name="Report @:#{Time.now}"
    puts name
    sleep 5
    self.report_title_element.when_present.clear
    self.report_title_element.when_present(15).set(name)
    self.report_desc_element.when_present(15).set"verify description"
    self.report_emmail1_element.when_present(15).set"prime_insight1@cisco.com"
    self.report_emmail2_element.when_present(15).set"prime_insight1@cisco.com"
    sleep 5
    ind=0
    until @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").present?
      ind=ind+1
      puts "schedule pop: #{ind}"
    end
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").span(:text=>"Save").when_present.flash.click
  end

  def interface_pin

    #    sleep 3
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    sleep 5
    @browser.div(:id,"#{popid}").div(:title=>"Pin").when_present.click
    sleep 3
    @browser.div(:id,"#{popid}").div(:title=>"Pin").title

  end

  def quickview_closepopup

    #    sleep 3
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:title=>"Close").when_present.flash.click
    if @browser.div(:id,"#{popid}").present?
      puts "Failure-Quickview popup window is not closed"
      return false
    else
      puts "Success-Quickview popup window is closed"
      return true
    end

  end

  def interface_detailview

    interface_name="Backplane-GigabitEthernet0/3"
    #    device_name="3560_switch_top.cisco.com"
    errorParent.div(:class=>"table-head-node-container").div(:class=>/xwtFilterByExample/).div(:class=>/cell-0/).text_field(:class=>/dijitInputInner/).when_present.set(interface_name)
    #    errorParent.div(:class=>"table-head-node-container").div(:class=>/xwtFilterByExample/).div(:class=>/cell-1/).text_field(:class=>/dijitInputInner/).when_present.set(device_name)
    sleep 10
    errorParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.click
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    sleep 5
    @browser.div(:id,"#{popid}").div(:class=>"DetailLink").when_present.flash.click
    sleep 3
    @browser.div(:class=>"pageTitleLabel").flash
    #    actual=@browser.span(:class=>"xwtBreadcrumbText xwtBreadcrumbLast").text
    actual=self.pageTitle_element.text
  end

  def errorTable_date_noRecords
    errorParent.div(:class=>"xwtGlobalToolbarActions").span(:class=>"totalCountLabel").when_present.flash
    errorParent.div(:class=>"xwtGlobalToolbarActions").span(:class=>"totalCountLabel").present?
    errorParent.div(:class=>"bottomIcons").when_present.flash
    chartTimestamp=errorParent.div(:class=>"bottomIcons").text
    actual=chartTimestamp[0..11]
    return actual
  end

  def errorDiscard_show_option_filter
    #    self.errorChartBottom_element.wd.location_once_scrolled_into_view
    errorParent.div(:class=>"dijitToolbar xwtContextualToolbar quickFilterExpanded").div(:class=>"dijitReset dijitRight dijitButtonNode dijitArrowButton dijitDownArrowButton dijitArrowButtonContainer icon-triangle icon-rotate-90").when_present.flash.click
    if $browser_type == :ie10
      errorParent.div(:class=>"dijitToolbar xwtContextualToolbar quickFilterExpanded").div(:class=>"dijitReset dijitRight dijitButtonNode dijitArrowButton dijitDownArrowButton dijitArrowButtonContainer icon-triangle icon-rotate-90").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 5
    actual=""
    actual<< @browser.div(:class=>"dijitPopup dijitMenuPopup").text
    return actual
  end

  def errorDiscards_quick_filter
    @browser.div(:class=>"dijitPopup dijitMenuPopup").tr(:index=>0).when_present.flash.click
  end

  def errorDiscardTable_export
    @browser.scroll.to :bottom
    errorParent.div(:class=>"bottomIcons").when_present.flash
    sleep 5
    errorParent.div(:class=>"bottomIcons").div(:title=>"Export").when_present.flash.click
    #    smallpop = @browser.div(:class,"dijitPopup Popup").id

    ind=0
    until @browser.div(:id,"popup_#{ind}").present?
      ind=ind+1
      puts "errorDiscardTable_export: #{ind}"
    end

    actual=[]
    all=@browser.div(:id,"popup_#{ind}").divs(:class=>"actionDropDownItem groupChild nonSelectable")
    all.each do |p|
      actual << p.div(:class,"dijitInline itemLabel").text
    end
    return actual
  end

  def errorDiscardTable_columnName
    sleep 3
    actual=[]
    all=errorParent.div(:class=>"table-header-container filter-by-example").tds(:class=>"cell-container")
    all.each do |p|
      p.div(:class=>"cell").focus
      actual << p.div(:class=>"cell").text
    end
    #  puts"ErrorDiscrds ColumnName: #{actual}"
    return actual
  end

  def errorDiscardTable_rowCount
    actual=errorParent.div(:class=>"xwtGlobalToolbarActions").span(:class=>"totalCountLabel").text
    total_count=actual.scan(/\d/).join('').to_i
    uiall=errorParent.div(:class=>"table dijitLayoutContainer dijitContainer emsamHiddenBottomLine").div(:class,"table-container").divs(:class,/row noSe/)
    table_row_count=uiall.size

    if total_count == table_row_count
      puts"Success-Row count is matched"
      return true
    else
      raise "Failure-Row count is miss-matched"
      return false
    end
  end

  def errorDiscards_Filter
    output=[]
    a=errorParent.div(:class=>"dijitInline filters").divs(:class=>"dijitInline dbFilter")
    a.each do |p|
      p.div(:class=>"dijitInline dbFilterLabel").flash
      output<<p.div(:class=>"dijitInline dbFilterLabel").text
    end
    return output
  end

  def tableValue_InerrorsColumn
    uiall = []
    uiall = errorParent.div(:class=>"table dijitLayoutContainer dijitContainer emsamHiddenBottomLine").div(:class,"table-container").divs(:class,/row noSe/)
    unsorted = []
    uiall.each do |p|
      p.table(:class,"row-table").tr.td(:class =>"cell-container", :index =>7).flash
      unsorted << p.table(:class,"row-table").tr.td(:class =>"cell-container", :index =>7).text
    end
    return unsorted
  end

  def errorsDiscards_4weeksTableData
    errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present(15).flash.click
    if $browser_type == :ie10
      errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    @browser.li(:text=>"Last 4 Weeks").when_present.flash.click
    errorParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>0).when_present.click
    sleep 3
    self.ok_a_element.fire_event "onclick"
    errorParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.click
    sleep 3
    self.ok_b_element.fire_event "onclick"
    errorParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 3
    self.tableValue_InerrorsColumn
  end

  def errorsDiscards_12weeksTableData
    errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present(15).flash.click
    if $browser_type == :ie10
      errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    @browser.li(:text=>"Last 12 Weeks").when_present.flash.click
    errorParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>0).when_present.click
    sleep 3
    self.ok_a_element.fire_event "onclick"
    errorParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.click
    sleep 3
    self.ok_b_element.fire_event "onclick"
    errorParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 3
    self.tableValue_InerrorsColumn
  end

  def errorsDiscards_24weeksTableData
    errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present(15).flash.click
    if $browser_type == :ie10
      errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    @browser.li(:text=>"Last 24 Weeks").when_present.flash.click
    errorParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>0).when_present.click
    sleep 3
    self.ok_a_element.fire_event "onclick"
    errorParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.click
    sleep 3
    self.ok_b_element.fire_event "onclick"
    errorParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 3
    self.tableValue_InerrorsColumn
  end

  def errorsDiscards_52weeksTableData
    errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present(15).flash.click
    if $browser_type == :ie10
      errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    @browser.li(:text=>"Last 52 Weeks").when_present.flash.click
    errorParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>0).when_present.click
    sleep 3
    self.ok_a_element.fire_event "onclick"
    errorParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.click
    sleep 3
    self.ok_b_element.fire_event "onclick"
    errorParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 3
    self.tableValue_InerrorsColumn
  end

  def errorsDiscards_56weeksTableData
    errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present(15).flash.click
    if $browser_type == :ie10
      errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    @browser.li(:text=>"Last 56 Weeks").when_present.flash.click
    errorParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>0).when_present.click
    sleep 3
    self.ok_a_element.fire_event "onclick"
    errorParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.click
    sleep 3
    self.ok_b_element.fire_event "onclick"
    errorParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 3
    self.tableValue_InerrorsColumn
  end

  def errorsDiscards_12MonthsTableData
    errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present(15).flash.click
    if $browser_type == :ie10
      errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    @browser.li(:text=>"Last 12 Months").when_present.flash.click
    errorParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>0).when_present.click
    sleep 3
    self.ok_a_element.fire_event "onclick"
    errorParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.click
    sleep 3
    self.ok_b_element.fire_event "onclick"
    errorParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 3
    self.tableValue_InerrorsColumn
  end

  def errorsDiscards_13MonthsTableData
    errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present(15).flash.click
    if $browser_type == :ie10
      errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    @browser.li(:text=>"Last 13 Months").when_present.flash.click
    errorParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>0).when_present.click
    sleep 3
    self.ok_a_element.fire_event "onclick"
    errorParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.click
    sleep 3
    self.ok_b_element.fire_event "onclick"
    errorParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 3
    self.tableValue_InerrorsColumn
  end

  def errorsDiscards_7DaysTableData
    errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present(15).flash.click
    if $browser_type == :ie10
      errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 3
    @browser.li(:text=>"Last 7 Days").when_present.flash.click
    errorParent.div(:class => "xwt_BasePickerBox" , :index => 0).div(:class,"xwt_BasePickerButton dijitDownArrowButton").click
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog xwt_BasePickerPopover dijitTooltipABLeft dijitTooltipBelow").id
    aval = popid.scan(/[0-9#]+/i)
    a = aval[0]
    popval = a.to_i
    sleep 3
    @browser.div(:id,"#{popid}").checkbox(:index =>1).click
    @browser.div(:id,"#{popid}").div(:id,"emsam_application_advancereports_globalfilters_SiteFilter_#{popval}_buttonContainer").span(:text,"OK").click
    errorParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 3
    self.tableValue_InerrorsColumn
  end

  def errorsDiscards_14DaysTableData
    errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present(15).flash.click
    if $browser_type == :ie10
      errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 3
    @browser.li(:text=>"Last 2 Weeks").when_present.flash.click
    errorParent.div(:class => "xwt_BasePickerBox" , :index => 1).div(:class,"xwt_BasePickerButton dijitDownArrowButton").click
    sleep 3
    self.ok_b_element.fire_event "onclick"
    errorParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 3
    self.tableValue_InerrorsColumn()
    self.errorsDiscards_4weeksTableData()
    self.errorsDiscards_12weeksTableData()
    self.errorsDiscards_24weeksTableData()
    self.errorsDiscards_52weeksTableData()
    self.errorsDiscards_56weeksTableData()
    self.errorsDiscards_12MonthsTableData()
    self.errorsDiscards_13MonthsTableData()

  end

  def errorsDiscards_interfaceGroupTable

    errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present(15).flash.click
    if $browser_type == :ie10
      errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    @browser.li(:text=>"Last 2 Weeks").when_present.flash.click # Check how to apply .yml data
    errorParent.div(:class => "xwt_BasePickerBox" , :index => 1).div(:class,"xwt_BasePickerButton dijitDownArrowButton").when_present.flash.click
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog xwt_BasePickerPopover dijitTooltipABLeft dijitTooltipBelow").id
    aval = popid.scan(/[0-9#]+/i)
    a = aval[0]
    popval = a.to_i
    @browser.div(:id,"#{popid}").div(:id,"emsam_application_advancereports_globalfilters_InterfaceFilter_#{popval}_buttonContainer").span(:text,"Clear Selections").when_present.flash.click
    sleep 2
    if @browser.div(:id,"#{popid}").div(:class,"dijitTreeRow isTreeNodeContainer dijitTreeRowSelected").div(:class,"xwtTreeNodeLabel").span(:class,"dijitTreeExpando dijitTreeExpandoClosed").exists?
      @browser.div(:id,"#{popid}").div(:class,"dijitTreeRow isTreeNodeContainer dijitTreeRowSelected").div(:class,"xwtTreeNodeLabel").span(:class,"dijitTreeExpando dijitTreeExpandoClosed").when_present.flash.click
    else
      if @browser.div(:id,"#{popid}").div(:class,"dijitTreeRow isTreeNodeContainer dijitTreeRowHover").div(:class,"xwtTreeNodeLabel").span(:class,"dijitTreeExpando dijitTreeExpandoOpened").exists?
        @browser.div(:id,"#{popid}").div(:class,"dijitTreeRow isTreeNodeContainer dijitTreeRowHover").div(:class,"xwtTreeNodeLabel").span(:class,"dijitTreeExpando dijitTreeExpandoOpened").when_present.flash.click
      end
    end
    @testval = 0
    labelind = 0
    @browser.div(:id,"#{popid}").spans(:class,"dijitTreeLabel").each do |p|
      if p.text == "System Defined"
        @testval = labelind
        puts "value", @testval
      end
      labelind = labelind + 1
    end
    @browser.div(:id,"#{popid}").checkbox(:index => @testval).when_present.flash.click
    @browser.div(:id,"#{popid}").div(:id,"emsam_application_advancereports_globalfilters_InterfaceFilter_#{popval}_buttonContainer").span(:text,"OK").when_present.flash.click
    errorParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 3
    self.tableValue_InerrorsColumn
  end

  def errorsDiscards_locationTable

    errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present(15).flash.click
    if $browser_type == :ie10
      errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 3
    @browser.li(:text=>"Last 2 Weeks").when_present.flash.click # Check how to apply .yml data
    errorParent.div(:class => "xwt_BasePickerBox" , :index => 0).div(:class,"xwt_BasePickerButton dijitDownArrowButton").when_present.flash.click
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog xwt_BasePickerPopover dijitTooltipABLeft dijitTooltipBelow").id
    aval = popid.scan(/[0-9#]+/i)
    a = aval[0]
    popval = a.to_i
    @browser.div(:id,"#{popid}").div(:id,"emsam_application_advancereports_globalfilters_SiteFilter_#{popval}_buttonContainer").span(:text,"Clear Selections").when_present.flash.click
    sleep 2
    if @browser.div(:id,"#{popid}").div(:class,"dijitTreeRow isTreeNodeContainer dijitTreeRowSelected").div(:class,"xwtTreeNodeLabel").span(:class,"dijitTreeExpando dijitTreeExpandoClosed").exists?
      @browser.div(:id,"#{popid}").div(:class,"dijitTreeRow isTreeNodeContainer dijitTreeRowSelected").div(:class,"xwtTreeNodeLabel").span(:class,"dijitTreeExpando dijitTreeExpandoClosed").when_present.flash.click
    else
      if @browser.div(:id,"#{popid}").div(:class,"dijitTreeRow isTreeNodeContainer dijitTreeRowHover").div(:class,"xwtTreeNodeLabel").span(:class,"dijitTreeExpando dijitTreeExpandoOpened").exists?
        @browser.div(:id,"#{popid}").div(:class,"dijitTreeRow isTreeNodeContainer dijitTreeRowHover").div(:class,"xwtTreeNodeLabel").span(:class,"dijitTreeExpando dijitTreeExpandoOpened").when_present.flash.click
      end
    end
    @testval = 0
    labelind = 0
    @browser.div(:id,"#{popid}").spans(:class,"dijitTreeLabel").each do |p|
      if p.text == "San Jose"
        @testval = labelind
        puts "value", @testval
      end
      labelind = labelind + 1
    end
    @browser.div(:id,"#{popid}").checkbox(:index => @testval).when_present.flash.click
    @browser.div(:id,"#{popid}").div(:id,"emsam_application_advancereports_globalfilters_SiteFilter_#{popval}_buttonContainer").span(:text,"OK").when_present.flash.click
    errorParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 3
    self.tableValue_InerrorsColumn
  end

  def errorsDiscardsDetailview_Date
    self.error_global_filter
    @browser.scroll.to :center
    interface_name="GigabitEthernet"
    errorParent.div(:class=>"table-head-node-container").div(:class=>"xwtFilterByExample").div(:class=>"cell-0").text_field(:class=>"dijitInputInner").when_present.set(interface_name)
    sleep 3
    errorParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present(5).flash.click
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    sleep 3
    output=[]
    a=@browser.div(:id,"#{popid}").div(:class=>"chartNode").element(:css => "svg").elements(:css => "text")
    a.each do |p|
      p.flash
      output<<p.text
    end
    puts output
    chartaxisdate = []
    output.each do |p|
      if p =~ /2015/
        chartaxisdate << p
      end
    end
    p chartaxisdate
    element=[]
    element << chartaxisdate.first
    element << chartaxisdate.last
    element.map!{ |element| element.gsub(/"/, '') }
    @browser.div(:id,"#{popid}").div(:class=>"DetailLink").when_present(5).flash.click
    sleep 3
    self.dateLink_element.when_present.focus
    self.dateLink_element.when_present.flash
    detail_date=self.dateLink_element.text
    date1 = detail_date.split('-')
    date2 = []
    date1.each do |p|
      if p =~ /UTC/
        date2 << p.split('UTC')
      else
        date2 << p
      end
    end
    if element.empty? && date2.empty?
      puts "Failure-Graph should not have valid date range from Quick View to Detail View"
      return false
    else
      puts "Success-Graph should have valid date range from Quick View to Detail View"
      return true
    end
  end

  def errorsDiscardsDetailview_CalculationMode
    self.radio_Absolute_element.when_present.flash.click
    @browser.input(:id,"inDiscards").when_present.flash.click
    @browser.input(:id,"outDiscards").when_present.flash.click
    self.applyFilter_element.when_present.click
    self.chartBottom_element.wd.location_once_scrolled_into_view
    output=[]
    a=@browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"chartNode").element(:css => "svg").elements(:css => "text")
    a.each do |p|
      output<<p.text
    end
    return output
  end

  def interfaceDetailview_ChartXaxisDate
    output=[]
    a=@browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"chartNode").element(:css => "svg").elements(:css => "text")
    a.each do |p|
      output<<p.text
    end
    chartaxisdate = []
    output.each do |p|
      if p =~ /2015/
        p chartaxisdate << p
      end
    end
    chartaxisdate = chartaxisdate.uniq
    puts "uniq date: #{chartaxisdate}"
    actual=chartaxisdate.size
    puts "uniq date : #{actual}"
    if actual == 14
      puts "It matches with the filter selection"
      return true
    else
      raise "There is a problem in date range in graph"
      return false
    end
  end

  def interfaceDetailview_GraphLegend
    self.chartLegend_element.present?
    self.chartLegend_element.flash
    legend=self.chartLegend_element.text
    if legend.empty?
      raise "Failure-Graph should not have legend"
      return false
    else
      puts "Success-Graph should have the legend"
      return true
    end
  end

  def interfaceDetailview_GraphLegendEnableDiable
    self.inputBox_element.clear
    self.outputBox_element.clear
    self.inputBox_element.click
    inputBox= @browser.div(:class,"chartNode").element(:css => "svg").element(:css => "polyline")
    self.inputBox_element.clear
    self.outputBox_element.click
    outputBox= @browser.div(:class,"chartNode").element(:css => "svg").element(:css => "polyline")
    if inputBox.present? && outputBox.present?
      puts "Success-Graph should have InputOutput Utilization"
      return true
    else
      raise "Failure-Graph should not have InputOutput Utilization"
      return false
    end
  end

  def interfaceDetailview_GraphValue
    self.inputBox_element.flash.click
    sleep 2
    chartelement = []
    all = @browser.div(:class,"chartNode").element(:css => "svg").elements(:css => "polyline")
    all.each do |p|
      p.when_present(15).click
      #      p.fire_event("onmouseover")
      p.hover
      chartelement << self.tooltipValue_element.text
      sleep 3
    end
    chartelement_uniq = chartelement.uniq
    return chartelement_uniq
  end

  def errorsDiscardsDetailview_PagingDetails
    #
    #    ind=0
    #    until @browser.div(:id,"custom_unmergedTools_#{ind}").present?
    #      ind=ind+1
    #    end

    @browser.div(:class=>"xwtTitlePane xwtTitlePaneTitle").wd.location_once_scrolled_into_view
    @browser.div(:class=>"xwtTitlePane xwtTitlePaneTitle").flash
    item= @browser.div(:class=>"xwtTitlePane xwtTitlePaneTitle")

    ##    @browser.div(:class=>"topDivAP").wd.location_once_scrolled_into_view
    #    @browser.div(:class=>"topDivAP").flash
    #     item=@browser.div(:class=>"topDivAP")
    if item.present?
      puts "Success-Details View have the proper Paging Details"
      return true
    else
      raise "Failure-Details View should not have the proper Paging Details"
      return false
    end
  end

  def interfaceDetailsview_FilterCollapseDecollapse
    @browser.scroll.to :top
    self.filterArrow_element.when_present.flash.click
    self.filterArrow_element.when_present.flash.click
    self.filterDiv_element.flash
    filterDiv=@browser.div(:id=>"filterDiv").tr(:index=>3)
    sleep 3
    if filterDiv.present?
      puts "Success- Filter option is properly collapsed and de-collapsed"
      return true
    else
      puts  "Failure- Filter option is not properly collapsed and de-collapsed"
      return false
    end
  end

  def interfaceDetailsview_timePeriod
    @browser.div(:id=>"filterDiv").tr(:index=>0).div(:class=>"dijitDownArrowButton").when_present.flash.click
    actual=[]
    sleep 2
    all=@browser.div(:class=> "dijitPopup dijitComboBoxMenuPopup").lis(:class=>"dijitReset dijitMenuItem")
    sleep 5
    all.each do |p|
      actual<<p.text
    end
    return actual
  end

  def interfaceDetailsview_multipleSelection
    @browser.scroll.to :top
    @browser.div(:id=>"filterDiv").tr(:index=>2).div(:class=>"dijitDownArrowButton").flash.click
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog xwt_BasePickerPopover dijitTooltipABLeft dijitTooltipBelow").id
    p popid
    avala = popid.scan(/[0-9#]+/i)
    a = avala[0]
    popvala = a.to_i
    p "before check box"
    sleep 5

    if $browser_type == :ie10
      @browser.div(:id,"#{popid}").span(:text=>"sjc-7200-2.cisco.com").parent.checkbox.click
    else
      @browser.div(:id,"#{popid}").span(:text=>"sjc-7200-2.cisco.com").parent.checkbox.fire_event('onclick')
    end

    if $browser_type == :ie10
      @browser.div(:id,"#{popid}").span(:text=>"DAL-3945-1").parent.checkbox.click
    else
      @browser.div(:id,"#{popid}").span(:text=>"DAL-3945-1").parent.checkbox.fire_event('onclick')
    end

    p "after check box"
    @browser.div(:id,"#{popid}").div(:id,"xwt_widget_form_ObjectSelectorMultiPicker_#{popvala}_buttonContainer").span(:text,"OK").flash.click
    actualDevices=@browser.div(:id=>"filterDiv").tr(:index=>2).div(:class=>"xwt_BasePickerDisplayBox").text
    sleep 3
    if actualDevices == "Multiple selections"
      puts "Success-Multiple selection is displayed"
    else
      puts "Failure-Multiple selection is not displayed"
    end
    #    @browser.div(:id=>"filterDiv").tr(:index=>3).div(:class=>"dijitDownArrowButton").when_present.click
    #    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog xwt_BasePickerPopover dijitTooltipABLeft dijitTooltipBelow").id
    #    p popid
    #    avalb = popid.scan(/[0-9#]+/i)
    #    b = avalb[0]
    #    popvalb = b.to_i
    #    p "before check box"
    #    @browser.div(:id,"#{popid}").span(:text=>"All").parent.checkbox.fire_event('onclick')
    #    p "after check box"
    #    @browser.div(:id,"#{popid}").div(:id,"xwt_widget_form_ObjectSelectorMultiPicker_#{popvala}_buttonContainer").span(:text,"OK").click
    #    actualInterfaces=@browser.div(:id=>"filterDiv").tr(:index=>3).div(:class=>"xwt_BasePickerDisplayBox").text
    #    puts actualInterfaces
  end

  def errosDiscardsDetailview_FilterSelectionData
    self.radio_Percent_element.when_present.flash.click
    @browser.input(:id,"outUtil").when_present.flash.click
    self.applyFilter_element.when_present.flash.click
    sleep 3
    begin
      @browser.div(:class=>"xwtAlert").span(:text=>"OK").when_present.flash.click
    rescue
      puts "Limit exceeded alert doesn't appear"
    end
    self.chartBottom_element.wd.location_once_scrolled_into_view
    output=[]
    a=@browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"chartNode").element(:css => "svg").elements(:css => "text")
    a.each do |p|
      output<<p.text
    end
    return output
  end

  def interfaceUtilDetailview_MergedData
    @browser.scroll.to :top
    self.radio_Merged_element.when_present.flash.click
    self.applyFilter_element.when_present.flash.click
    sleep 3
    begin
      @browser.div(:class=>"xwtAlert").span(:text=>"OK").when_present.flash.click
    rescue
      puts "Limit exceeded alert doesn't appear"
    end
    self.chartBottom_element.wd.location_once_scrolled_into_view
    output=[]
    a=@browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"chartNode").element(:css => "svg").elements(:css => "text")
    a.each do |p|
      output<<p.text
    end
    return output
  end

  def interfaceUtilDetailview_AddFavourite
    self.pageTitle_element.flash
    self.favouriteIcon_element.when_present.flash.click
    self.toggleIcon_element.when_present.flash.click
    self.favouriteMenu_element.when_present.flash.click
    self.favouriteTitles_element.flash
    allTitle=[]
    all=@browser.div(:class=>"xwtSlideMenuFavoritesContainerNodeContainer").divs(:class=>"xwtSlideMenuMenuItemText")
    all.each do |p|
      allTitle<<p.text
    end
    return allTitle
  end

  def interfaceUtilDetailview_FilterSelectionData
    self.radio_Percent_element.when_present.flash.click
    @browser.input(:id,"inErrors").when_present.flash.click
    self.applyFilter_element.when_present.flash.click
    sleep 3
    begin
      @browser.div(:class=>"xwtAlert").span(:text=>"OK").flash.click
    rescue
      puts "Limit exceeded alert doesn't appear"
    end
    self.chartBottom_element.wd.location_once_scrolled_into_view
    output=[]
    a=@browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"chartNode").element(:css => "svg").elements(:css => "text")
    a.each do |p|
      output<<p.text
    end
    return output
  end

  def interface_ScheduleReport
    @browser.scroll.to :bottom
    @browser.div(:class=>"bottomRegion").wd.location_once_scrolled_into_view
    @browser.div(:class=>"bottomRegion").div(:class=>"bottomIcons").flash
    @browser.div(:class=>"bottomRegion").div(:class=>"bottomIcons").div(:title=>"Export").when_present.flash.click
    smallpop = @browser.div(:class,"dijitPopup Popup").id
    @browser.div(:id,"#{smallpop}").div(:text=>"Schedule Report").when_present.flash.click
    ind=0
    until @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").present?
      puts "interface_ScheduleReport: #{ind}"
      ind = ind + 1
    end
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").flash
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").text_field(:name=>"title").set("interface Report:#{Time.now}")
    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").span(:text=>"Save").when_present.flash.click
    #    self.alertYES_element.when_present.click
  end

  def detailVewTimeperiodFilter_GlobalFilter
    navigate_application_to "Home"
    sleep 10
    puts "Get into detailVewTimeperiodFilter_GlobalFilter"
    errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 3
    @browser.li(:text=>"Last 2 Weeks").focus
    @browser.li(:text=>"Last 2 Weeks").flash.double_click
    actual=errorParent.div(:class =>"dashboardFilter").input(:class=>"dijitReset dijitInputInner").flash.value
    puts"Actual Time Period Value: #{actual}"
    errorParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 3
    @browser.scroll.to :center
    interface_name="GigabitEthernet"
    errorParent.div(:class=>"table-head-node-container").div(:class=>"xwtFilterByExample").div(:class=>"cell-0").text_field(:class=>"dijitInputInner").when_present.set(interface_name)
    interfaceName=errorParent.div(:class=>"table-container").div(:class=>/row noSe/).table(:class,"row-table").tr.td(:class =>"cell-container",:index =>0).text
    deviceName=errorParent.div(:class=>"table-container").div(:class=>/row noSe/).table(:class,"row-table").tr.td(:class =>"cell-container",:index =>1).text
    $expect=interfaceName<<"@"+deviceName
    puts"Expect Interface and Device Value: #{$expect}"
    sleep 8
    if $browser_type == :ie10
      errorParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.double_click
    else
      errorParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.click
    end
    sleep 3
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"DetailLink").when_present.flash.click
    sleep 10
    expect=@browser.div(:id=>"filterDiv").tr(:index=>0).input(:id=>"timeRangeDropdown").flash.value
    puts"Expect Time Period Value: #{expect}"
    firstExpect="Last "
    expectFinal=firstExpect.concat(expect)

    if actual == expectFinal
      puts"Success---By Timeperiod Filter is similar to Global Filter"
      return true
    else
      puts "Failure---By Timeperiod Filter is not similar to Global Filter"
      return false
    end
  end

  def detailVew_DevicesInterfaces
    puts "@expect: #{$expect}"
    actual=@browser.div(:id=>"filterDiv").tr(:index=>3).div(:class=>"xwt_BasePickerDisplayBox").text
    puts"Actual Interface and Device Value: #{actual}"
    if $expect == actual
      puts"Success---Interface And Device Name is similar to Selected"
      return true
    else
      puts "Failure---Interface And Device Name is Not similar to Selected"
      return false
    end
  end

  def detailView_DevicesInterfaces_FilterALLOption
    @browser.div(:id=>"filterDiv").tr(:index=>1).div(:class=>"dijitDownArrowButton").when_present.flash.click
    @browser.div(:class=>"xwt_BasePickerPopoverButtonContainer").span(:text=>"OK").when_present.flash.click
    actual=[]
    actual<<@browser.div(:id=>"filterDiv").tr(:index=>2).div(:class=>"xwt_BasePickerDisplayBox").text
    actual<<@browser.div(:id=>"filterDiv").tr(:index=>3).div(:class=>"xwt_BasePickerDisplayBox").text
    puts"Actual Interface and Device Value: #{actual}"
    return actual
  end

  def detailView_Graph_InErrorsOutErrors
    @browser.div(:id=>"filterDiv").span(:id=>"resetBt_label").when_present.flash.click
    sleep 3
    @browser.input(:id,"inErrors").when_present.flash.click
    @browser.input(:id,"outErrors").when_present.flash.click
    self.applyFilter_element.when_present.flash.click
    self.chartBottom_element.wd.location_once_scrolled_into_view
    chartelement = []
    all = @browser.div(:class => "chartNode").elements(:css => "svg")
    all.each do |p|
      p.when_present(15).click
      #      p.fire_event("onmouseover")
      p.hover
      chartelement << self.tooltipValue_element.text
      sleep 3
    end
    puts "Tooltib Value Before Uniq: #{chartelement}"
    chartelement_uniq = chartelement.uniq
    puts "Tooltib Value After Uniq: #{chartelement_uniq}"
    return chartelement_uniq
  end

  def detailView_ResetDeviceField
    @browser.scroll.to :top
    @browser.div(:id=>"filterDiv").tr(:index=>1).div(:class=>"dijitDownArrowButton").when_present.flash.click
    @browser.div(:class=>"xwt_BasePickerPopoverButtonContainer").span(:text=>"OK").when_present.flash.click
    sleep 3
    actual=@browser.div(:id=>"filterDiv").tr(:index=>2).div(:class=>"xwt_BasePickerDisplayBox").text
    @browser.div(:id=>"filterDiv").span(:id=>"resetBt_label").when_present.flash.click
    sleep 2
    expect=@browser.div(:id=>"filterDiv").tr(:index=>2).div(:class=>"xwt_BasePickerDisplayBox").text
    if actual == expect
      puts "Failure-Device Field not regaining original position"
      return false
    else
      puts "Success-Device Field regaining original position"
      return true
    end
  end

  def detailView_ResetClaculationModeGraphView
    self.radio_Absolute_element.when_present.flash.click
    self.radio_Merged_element.when_present.flash.click
    @browser.div(:id=>"filterDiv").span(:id=>"resetBt_label").when_present.flash.click
    sleep 2
    if self.radio_Percent_element.checked? && self.radio_Individual_element.checked?
      puts "Success-Claculation Mode,GraphView Field regaining original position"
      return true
    else
      puts "Failure-Claculation Mode,GraphView Field not regaining original position"
      return false
    end
  end

end
