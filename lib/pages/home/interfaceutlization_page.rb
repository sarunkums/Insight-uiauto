class InterfaceUtilizationPage < ErrorsandDiscardsPage

  div(:container, :id=>'com_cisco_xmp_web_page_Getting_Started')
  span(:interface,:class=>"tabLabel",:text=>"Interface Utilization")
  div(:table,:class=>"table dijitLayoutContainer dijitContainer emsamHiddenBottomLine")
  div(:durationFilter,:class=>"dijitInline dbFilter")
  text_field(:durationFilterBox){durationFilter_element.input(:class=>"dijitReset dijitInputInner")}
  div(:durationReset){durationFilter_element.div(:class=>"dijitReset dijitValidationIcon")}
  #Page object for interface Utilization chart and table
  div(:chart,:class=>"chartNode")

  #  div(:interfacePercentage){chart_element.element(:text=>"Percentage")}
  #  div(:interfaceTimePeriod){chart_element.element(:text=>"Time Period")}

  div(:tablelayout,:class=>"table dijitLayoutContainer")
  div(:global_toolbar, :class=>'xwtGlobalToolbar')
  span(:totalRecord){global_toolbar_element.span(:class=>"totalCountLabel")}
  div(:date,:class=>"bottomIcons")
  div(:toolbar,:class=>"xwtQuickFilter")
  div(:filter_drodown){toolbar_element.div(:class=>"icon-triangle")}
  div(:quick,:text=>"Quick Filter")
  div(:filter_option,:class=>"dijitMenuPopup")
  div(:tableBottom,:class=>"gridChartPanel bottomRegion")
  div(:export){tableBottom_element.div(:title=>"Export")}

  div(:chartHorizontal,:class=>"chartPanelHorizontalLegend")
  checkbox(:inputCheckBox){chartHorizontal_element.checkbox(:class=>"dijitReset dijitCheckBoxInput",:index=>0)}
  checkbox(:outputCheckBox){chartHorizontal_element.checkbox(:class=>"dijitReset dijitCheckBoxInput",:index=>1)}
  #  div(:allcheckbox,:class=>"select_unselect1")
  #  checkbox(:allINOPCheckBox){allcheckbox_element.checkbox(:id=>"select_unselect")}
  checkbox(:allINOPCheckBox,:id=>"select_unselect")
														 
#Page object for interface Utilization Calendar View
  radio(:radio_hourly, :id=>"hourSelect")
  radio(:radio_daily, :id=>"weekSelect")
  span(:apply_filter,:text=>"Apply Filter")
  div(:chartactIcon,:class=>"chartActionIcon")
  div(:showpatt,:text=>"Show Patterns")
  div(:globaltooltip,:id=>"global_intervalToolTip")
  div(:table_Icon,:class=>"tableIcon")
  div(:chart_Icon,:class=>"chartIcon")
  div(:chartmoreIcon,:class=>"chartMoreActionIcon")
  radio(:radio_siteselect,:id=>"siteSelect")
  radio(:radio_ifselect, :id=>"interfaceSelect")

  def goto
    navigate_application_to "Home"
  end

  def interfaceParent
    ind = 0
    while ! @browser.div(:id,"xwt_widget_layout_TabContentPane_#{ind}").present?
      puts ind
      ind = ind + 1
    end
    @browser.div(:id,"xwt_widget_layout_TabContentPane_#{ind}")
  end

  def interface_duration
    sleep 10
    interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
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

  def interface_location

    interfaceParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>0).when_present.flash.click
    sleep 3
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

  def interface_group

    interfaceParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.flash.click
    sleep 3
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

  def interface_setting
    @browser.scroll.to :center
    interfaceParent.div(:class=>"xwtGlobalToolbarActions").span(:class=>"dijitReset dijitStretch dijitButtonContents dijitDownArrowButton").when_present.flash.click
    self.column_element.when_present.flash.click
    @browser.div(:class=>"columnsContainerDiv").td(:text=>"In Errors").when_present.flash.click
    self.close_element.when_present.flash.click

    if interfaceParent.div(:class=>"table-head-node-container").div(:text=>"In Errors").present?
      puts "Success-The new column is added on interface utilization table"
      return true
    else
      puts "Failure-The new column is not added on interface utilization table"
      return false
    end

  end

  def home_tabs
    actuall=[]
    sleep 2
    all=@browser.div(:class=>"dijitTabContainerTop-tabs").divs(:class=>"dijitTabInnerDiv")
    all.each do |p|
      actuall<<p.span(:class=>"tabLabel").text
    end
    return actuall

  end

  def detail_calender_view
    sleep 3
    interfaceParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present(5).click
    sleep 5
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    actual=[]
    @browser.div(:id,"#{popid}").div(:class=>"CalenderLink").when_present.flash
    actual<<@browser.div(:id,"#{popid}").div(:class=>"CalenderLink").text
    @browser.div(:id,"#{popid}").div(:class=>"DetailLink").when_present.flash
    actual<<@browser.div(:id,"#{popid}").div(:class=>"DetailLink").text
    return actual
  end

  def interface_table
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:title=>"Close").when_present.flash.click
  end

  def interfaceTable_date_noRecords
    self.date_element.when_present.flash
    chartTimestamp=self.date_element.text
    actual=chartTimestamp[0..11]
    return actual
  end

  def show_option_filter

    self.chartBottom_element.wd.location_once_scrolled_into_view
    sleep 3
    self.filter_drodown_element.flash.click
    actual=""
    sleep 3
    self.filter_option_element.focus
    actual<<self.filter_option_element.text
    return actual
  end

  def interfaceTable_export
    sleep 10
    self.export_element.when_present.flash.click
    smallpop = @browser.div(:class,"dijitPopup Popup").id
    actual=[]
    all=@browser.div(:id,"#{smallpop}").divs(:class,"actionDropDownItem groupChild nonSelectable")
    all.each do |p|
      actual << p.div(:class,"dijitInline itemLabel").text
    end
    return actual
  end

  def interfaceTable_rowCount
    uiall=@browser.div(:class=>"table dijitLayoutContainer dijitContainer emsamHiddenBottomLine").div(:class,"table-container").divs(:class,/row noSe/)
    table_row_count=uiall.size
    return table_row_count
  end

  def interfaceUtilization_Filter
    output=[]
    a=@browser.div(:class=>"dijitInline filters").divs(:class=>"dijitInline dbFilter")
    a.each do |p|
      p.div(:class=>"dijitInline dbFilterLabel").flash
      output<<p.div(:class=>"dijitInline dbFilterLabel").text
    end
    return output
  end

  def interface_global_filter
    p "get into global filter"
    sleep 10
    interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 5
    @browser.li(:text=>"Last 2 Weeks").focus
    @browser.li(:text=>"Last 2 Weeks").flash.double_click
    interfaceParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>0).when_present.click
    sleep 3
    #    self.ok_a_element.fire_event "onclick"
    interfaceParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.click
    sleep 3
    #    self.ok_b_element.fire_event "onclick"
    interfaceParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click

  end

  def graphDatafor7Days

    output=[]
    a=@browser.div(:class=>"chartNode").element(:css => "svg").elements(:css => "text")
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
    chartdate = []
    chartaxisdate.each do |p|
      chartdate << p.reverse.split(' ', 3).collect(&:reverse).reverse
    end
    chartdate = chartdate.flatten
    charttrimmeddate = []
    chartdate.each do |p|
      if p =~ /2015/
        p charttrimmeddate << p
      end
    end
    charttrimmeddate = charttrimmeddate.uniq
    puts "uniq date: #{charttrimmeddate}"
    actual=charttrimmeddate.size
    puts "uniq date : #{actual}"
    if actual == 7
      puts "It matches with the filter selection"
      return true
    else
      raise "There is a problem in date range in graph"
      return false
    end
  end

  def graphDatafor14Days

    output=[]
    a=@browser.div(:class=>"chartNode").element(:css => "svg").elements(:css => "text")
    a.each do |p|
      p.flash
      output<<p.text
    end
    puts output
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

  def graphDataAllDuration(value)
    sleep 15
    interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    p "Duration:#{value}"
    sleep 10
    @browser.li(:text=>value).when_present.click # Check how to apply .yml data
    interfaceParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    output=[]
    a=@browser.div(:class=>"chartNode").element(:css => "svg").elements(:css => "text")
    a.each do |p|
      p.flash
      output<<p.text
    end
    puts output
    chartaxisdate = []
    output.each do |p|
      if p =~ /2015/
        p chartaxisdate << p
      end
    end
    chartaxisdate = chartaxisdate.uniq
    puts "uniq date: #{chartaxisdate}"

    if chartaxisdate.empty?
      raise "Failure-Graph should not have the data"
      return false
    else
      puts "Success-Graph should have the data"
      return true
    end
  end

  def tableDatafor7Days

    uiall = []
    uiall = @browser.div(:class=>"gridNode").div(:class=>"dojoxGridContent").divs(:class=>"dojoxGridRow")
    unsorted = []
    uiall.each do |p|
      p.table(:class=>"dojoxGridRowTable").tr.td(:class =>/dojoxGridCell/, :index =>0).flash
      unsorted << p.table(:class=>"dojoxGridRowTable").tr.td(:class =>/dojoxGridCell/,:index =>0).text
    end

    tabledate = []
    unsorted.each do |p|
      tabledate << p.reverse.split(' ', 3).collect(&:reverse).reverse
    end
    tabledate = tabledate.flatten
    tabletrimmeddate = []
    tabledate.each do |p|
      if p =~ /2015/
        tabletrimmeddate << p
      end
    end
    puts "With out uniq date: #{tabletrimmeddate}"
    tabletrimmeddate = tabletrimmeddate.uniq
    puts "uniq date: #{tabletrimmeddate}"
    actual=tabletrimmeddate.size
    puts "uniq date : #{actual}"
    if tabletrimmeddate.empty?
      raise "There is a problem in date range in table"
      return false
    else
      puts "It matches with the filter selection"
      return true
    end
  end

  def tableDatafor14Days

    uiall = []
    uiall = @browser.div(:class=>"gridNode").div(:class=>"dojoxGridContent").divs(:class=>"dojoxGridRow")
    unsorted = []
    uiall.each do |p|
      p.table(:class=>"dojoxGridRowTable").tr.td(:class => "dojoxGridCell", :index =>0).flash
      unsorted << p.table(:class=>"dojoxGridRowTable").tr.td(:class =>"dojoxGridCell",:index =>0).text
    end
    unsorted=unsorted.uniq
    puts "uniq date: #{unsorted}"
    actual=unsorted.size
    puts "uniq date : #{actual}"
    puts unsorted
    if actual == 14
      puts "It matches with the filter selection"
      return true
    else
      raise "There is a problem in date range in table"
      return false
    end
  end

  def tableDataAllDuration(value)
    sleep 15
    interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    p "Duration:#{value}"
    @browser.li(:text=>value).when_present.click # Check how to apply .yml data
    interfaceParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    uiall = []
    uiall = @browser.div(:class=>"gridNode").div(:class,"dojoxGridContent").divs(:class,/dojoxGridRow/)
    unsorted = []
    uiall.each do |p|
      p.table(:class,"dojoxGridRowTable").tr.td(:class => /dojoxGridCell/, :index =>0).flash
      unsorted << p.table(:class,"dojoxGridRowTable").tr.td(:class =>/dojoxGridCell/,:index =>0).text
    end
    unsorted=unsorted.uniq
    puts  "Table uniq data: #{unsorted}"
    if unsorted.empty?
      raise "Failure-Table should not have the data"
      return false
    else
      puts "Success-Table should have the data"
      return true
    end
  end

  def interfaceUtilization_7DaysGraphData

    interfaceParent.div(:class=>"bottomRegion").div(:class,"dijitInline icon chartIcon").focus
    interfaceParent.div(:class=>"bottomRegion").div(:class,"dijitInline icon chartIcon").when_present.flash.click
    sleep 15
    @browser.scroll.to :top
    #    interfaceParent.div(:class =>"dashboardFilter").wd.location_once_scrolled_into_view
    interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 10
    @browser.li(:text=>"Last 7 Days").focus
    @browser.li(:text=>"Last 7 Days").flash.double_click
    interfaceParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    self.graphDatafor7Days()
  end

  def interfaceUtilization_14DaysGraphData
    sleep 15
    @browser.scroll.to :top
    #    interfaceParent.div(:class =>"dashboardFilter").wd.location_once_scrolled_into_view
    interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 10
    @browser.li(:text=>"Last 2 Weeks").focus
    @browser.li(:text=>"Last 2 Weeks").flash.double_click # Check how to apply .yml data
    interfaceParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 3
    self.graphDatafor14Days()
    self.graphDataAllDuration("Last 4 Weeks")
    self.graphDataAllDuration("Last 12 Weeks")
    self.graphDataAllDuration("Last 24 Weeks")
    self.graphDataAllDuration("Last 52 Weeks")
    self.graphDataAllDuration("Last 56 Weeks")
    self.graphDataAllDuration("Last 12 Months")
    self.graphDataAllDuration("Last 13 Months")
  end

  def interfaceUtilization_7DaysTableData
    p "get into interfaceUtilization_7DaysTableData"
    sleep 15
    @browser.scroll.to :top
    #    interfaceParent.div(:class =>"dashboardFilter").wd.location_once_scrolled_into_view
    interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 10
    @browser.li(:text=>"Last 7 Days").focus
    @browser.li(:text=>"Last 7 Days").flash.double_click
    interfaceParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 3
    interfaceParent.div(:class=>"bottomRegion").div(:class,"dijitInline icon tableIcon").focus
    interfaceParent.div(:class=>"bottomRegion").div(:class,"dijitInline icon tableIcon").when_present.flash.click
    sleep 3
    self.tableDatafor7Days()
  end

  def interfaceUtilization_14DaysTableData
    sleep 15
    @browser.scroll.to :top
    #    interfaceParent.div(:class =>"dashboardFilter").wd.location_once_scrolled_into_view
    interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 10
    @browser.li(:text=>"Last 2 Weeks").focus
    @browser.li(:text=>"Last 2 Weeks").flash.double_click
    interfaceParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 3
    self.tableDatafor14Days()
    self.tableDataAllDuration("Last 4 Weeks")
    self.tableDataAllDuration("Last 12 Weeks")
    self.tableDataAllDuration("Last 24 Weeks")
    self.tableDataAllDuration("Last 52 Weeks")
    self.tableDataAllDuration("Last 56 Weeks")
    self.tableDataAllDuration("Last 12 Months")
    self.tableDataAllDuration("Last 13 Months")
  end

  def interface_filterLocationTable
    sleep 15
    @browser.scroll.to :top
    #    interfaceParent.div(:class =>"dashboardFilter").wd.location_once_scrolled_into_view
    interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 10
    @browser.li(:text=>"Last 2 Weeks").focus
    @browser.li(:text=>"Last 2 Weeks").flash.double_click
    sleep 3
    interfaceParent.div(:class => "xwt_BasePickerBox" , :index => 0).div(:class,"xwt_BasePickerButton dijitDownArrowButton").flash.click
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog xwt_BasePickerPopover dijitTooltipABLeft dijitTooltipBelow").id
    aval = popid.scan(/[0-9#]+/i)
    a = aval[0]
    popval = a.to_i
    sleep 3
    @browser.div(:id,"#{popid}").div(:id,"emsam_application_advancereports_globalfilters_SiteFilter_#{popval}_buttonContainer").span(:text,"Clear Selections").when_present.flash.click
    p "clear success"
    sleep 2
    if @browser.div(:id,"#{popid}").div(:class,"dijitTreeRow isTreeNodeContainer dijitTreeRowSelected").div(:class,"xwtTreeNodeLabel").span(:class,"dijitTreeExpando dijitTreeExpandoClosed").exists?
      @browser.div(:id,"#{popid}").div(:class,"dijitTreeRow isTreeNodeContainer dijitTreeRowSelected").div(:class,"xwtTreeNodeLabel").span(:class,"dijitTreeExpando dijitTreeExpandoClosed").flash.click
    else
      if @browser.div(:id,"#{popid}").div(:class,"dijitTreeRow isTreeNodeContainer dijitTreeRowHover").div(:class,"xwtTreeNodeLabel").span(:class,"dijitTreeExpando dijitTreeExpandoOpened").exists?
        @browser.div(:id,"#{popid}").div(:class,"dijitTreeRow isTreeNodeContainer dijitTreeRowHover").div(:class,"xwtTreeNodeLabel").span(:class,"dijitTreeExpando dijitTreeExpandoOpened").flash.click
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
    @browser.div(:id,"#{popid}").checkbox(:index => @testval).click
    @browser.div(:id,"#{popid}").div(:id,"emsam_application_advancereports_globalfilters_SiteFilter_#{popval}_buttonContainer").span(:text,"OK").flash.click

    interfaceParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.flash.click
    sleep 3
    #    self.ok_b_element.fire_event "onclick"
    interfaceParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 3
    interfaceParent.div(:class=>"bottomRegion").div(:class,"dijitInline icon tableIcon").focus
    interfaceParent.div(:class=>"bottomRegion").div(:class,"dijitInline icon tableIcon").when_present.flash.click
    sleep 3
    self.tableDatafor14Days()
  end

  def interface_filterGraph
    sleep 3
    interfaceParent.div(:class=>"bottomRegion").div(:class,"dijitInline icon chartIcon").focus
    interfaceParent.div(:class=>"bottomRegion").div(:class,"dijitInline icon chartIcon").when_present.flash.click
    sleep 3
    self.graphDatafor14Days()
  end

  def interface_filterInterfaceGroupTable
    sleep 15
    @browser.scroll.to :top
    #    interfaceParent.div(:class =>"dashboardFilter").wd.location_once_scrolled_into_view
    interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 10
    @browser.li(:text=>"Last 2 Weeks").when_present.flash.click
    sleep 3
    interfaceParent.div(:class => "xwt_BasePickerBox" , :index => 1).div(:class,"xwt_BasePickerButton dijitDownArrowButton").flash.click
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog xwt_BasePickerPopover dijitTooltipABLeft dijitTooltipBelow").id
    aval = popid.scan(/[0-9#]+/i)
    a = aval[0]
    popval = a.to_i
    sleep 3
    @browser.div(:id,"#{popid}").div(:id,"emsam_application_advancereports_globalfilters_InterfaceFilter_#{popval}_buttonContainer").span(:text,"Clear Selections").when_present.flash.click
    p "clear success"
    sleep 2
    if @browser.div(:id,"#{popid}").div(:class,"dijitTreeRow isTreeNodeContainer dijitTreeRowSelected").div(:class,"xwtTreeNodeLabel").span(:class,"dijitTreeExpando dijitTreeExpandoClosed").exists?
      @browser.div(:id,"#{popid}").div(:class,"dijitTreeRow isTreeNodeContainer dijitTreeRowSelected").div(:class,"xwtTreeNodeLabel").span(:class,"dijitTreeExpando dijitTreeExpandoClosed").flash.click
    else
      if @browser.div(:id,"#{popid}").div(:class,"dijitTreeRow isTreeNodeContainer dijitTreeRowHover").div(:class,"xwtTreeNodeLabel").span(:class,"dijitTreeExpando dijitTreeExpandoOpened").exists?
        @browser.div(:id,"#{popid}").div(:class,"dijitTreeRow isTreeNodeContainer dijitTreeRowHover").div(:class,"xwtTreeNodeLabel").span(:class,"dijitTreeExpando dijitTreeExpandoOpened").flash.click
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
    @browser.div(:id,"#{popid}").checkbox(:index => @testval).flash.click
    @browser.div(:id,"#{popid}").div(:id,"emsam_application_advancereports_globalfilters_InterfaceFilter_#{popval}_buttonContainer").span(:text,"OK").flash.click
    interfaceParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 5
    interfaceParent.div(:class=>"bottomRegion").div(:class,"dijitInline icon tableIcon").when_present.flash.click
    sleep 3
    self.tableDatafor14Days()
  end

  def interfaceUtilDetailview_Date
    self.interface_global_filter
    @browser.scroll.to :center
    interface_name="GigabitEthernet"
    interfaceParent.div(:class=>"table-head-node-container").div(:class=>"xwtFilterByExample").div(:class=>"cell-0").text_field(:class=>"dijitInputInner").when_present.set(interface_name)
    sleep 8

    if $browser_type == :ie10
      interfaceParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.double_click
    else
      interfaceParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.click
    end

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
    @browser.div(:id,"#{popid}").div(:class=>"DetailLink").when_present.flash.click
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

  def interfaceDetailview_DateHyperLink
    self.dateLink_element.when_present.flash.click
    actual=self.datePopUpTitle_element.text
    return actual
  end

  def interfaceDetailview_CalculationMode
    self.datePopUpClose_element.when_present.flash.click
    self.radio_Absolute_element.when_present.flash.click
    self.applyFilter_element.when_present.flash.click
    self.chartBottom_element.wd.location_once_scrolled_into_view
    output=[]
    a=@browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"chartNode").element(:css => "svg").elements(:css => "text")
    a.each do |p|
      output<<p.text
    end
    return output
  end

  def interfaceDetailview_PagingDetails
    @browser.scroll.to :top
    @browser.div(:class=>"xwtTitlePane xwtTitlePaneTitle",:index=>1).wd.location_once_scrolled_into_view
    @browser.div(:class=>"xwtTitlePane xwtTitlePaneTitle",:index=>1).flash
    item=@browser.div(:class=>"xwtTitlePane xwtTitlePaneTitle",:index=>1)
    if item.present?
      puts "Success-Details View have the proper Paging Details"
      return true
    else
      raise "Failure-Details View should not have the proper Paging Details"
      return false
    end
    #    sleep 2
    #    @browser.div(:id=>"filterDiv").tr(:index=>3).div(:class=>"dijitDownArrowButton").flash
    #    @browser.div(:id=>"filterDiv").tr(:index=>3).div(:class=>"dijitDownArrowButton").when_present.click
    #    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog xwt_BasePickerPopover dijitTooltipABLeft dijitTooltipBelow").id
    #    p popid
    #    aval = popid.scan(/[0-9#]+/i)
    #    a = aval[0]
    #    popval = a.to_i
    #    @browser.div(:id,"#{popid}").span(:text=>"All").wd.location_once_scrolled_into_view
    #    @browser.div(:id,"#{popid}").span(:text=>"All").when_present.click
    #    @browser.div(:id,"#{popid}").div(:id,"xwt_widget_form_ObjectSelectorMultiPicker_#{popval}_buttonContainer").span(:text,"OK").click
    #    p "before apply"
    #    @browser.div(:id,"filterButtonGroup").span(:id,"applyBt").when_present.click
    #    p "after apply"
    #    sleep 10
    #    @browser.div(:class=>"xwtTitlePane xwtTitlePaneTitle",:index=>1).wd.location_once_scrolled_into_view
    #    @browser.div(:class=>"xwtTitlePane xwtTitlePaneTitle",:index=>1).flash
    #    item=@browser.div(:class=>"xwtTitlePane xwtTitlePaneTitle",:index=>1).span(:index=>26).text
    #    if item != "Items 1-1 of 1"
    #      puts "Success-Details View have the proper Paging Details"
    #      return true
    #    else
    #      raise "Failure-Details View should not have the proper Paging Details"
    #      return false
    #    end
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

  #  def interface_ScheduleReport
  #    @browser.scroll.to :bottom
  #    @browser.div(:class=>"bottomRegion").wd.location_once_scrolled_into_view
  #    @browser.div(:class=>"bottomRegion").div(:class=>"bottomIcons").flash
  #    @browser.div(:class=>"gridChartPanel bottomRegion").div(:class=>"bottomIcons").div(:title=>"Export").when_present.flash.click
  #    smallpop = @browser.div(:class,"dijitPopup Popup").id
  #    @browser.div(:id,"#{smallpop}").div(:text=>"Schedule Report").when_present.flash.click
  #    ind=0
  #    until @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").present?
  #      puts ind
  #      ind = ind + 1
  #    end
  #    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").flash
  #    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").text_field(:name=>"title").set("interface Report:#{Time.now}")
  #    @browser.div(:id,"xwt_widget_layout_Dialog_#{ind}").span(:text=>"Save").when_present.flash.click
  #    #    self.alertYES_element.when_present.click
  #  end

  def interfacedetailVewTimeperiodFilter_GlobalFilter
    navigate_application_to "Home"
    sleep 10
    puts "Get into detailVewTimeperiodFilter_GlobalFilter"
    #    interfaceParent.div(:class =>"dashboardFilter").wd.location_once_scrolled_into_view
    @browser.scroll.to :top
    interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      interfaceParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 3
    @browser.li(:text=>"Last 2 Weeks").focus
    @browser.li(:text=>"Last 2 Weeks").flash.double_click
    actual=interfaceParent.div(:class =>"dashboardFilter").input(:class=>"dijitReset dijitInputInner").flash.value
    puts"Actual Time Period Value: #{actual}"
    interfaceParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 3
    @browser.scroll.to :center
    interface_name="GigabitEthernet"
    interfaceParent.div(:class=>"table-head-node-container").div(:class=>"xwtFilterByExample").div(:class=>"cell-0").text_field(:class=>"dijitInputInner").when_present.clear
    interfaceParent.div(:class=>"table-head-node-container").div(:class=>"xwtFilterByExample").div(:class=>"cell-1").text_field(:class=>"dijitInputInner").click
    interfaceParent.div(:class=>"table-head-node-container").div(:class=>"xwtFilterByExample").div(:class=>"cell-0").text_field(:class=>"dijitInputInner").when_present.set(interface_name)
    interfaceName=interfaceParent.div(:class=>"table-container").div(:class=>/row noSe/).table(:class,"row-table").tr.td(:class =>"cell-container",:index =>0).text
    deviceName=interfaceParent.div(:class=>"table-container").div(:class=>/row noSe/).table(:class,"row-table").tr.td(:class =>"cell-container",:index =>1).text
    $expect=interfaceName<<"@"+deviceName
    puts"Expect Interface and Device Value: #{$expect}"
    sleep 8
    if $browser_type == :ie10
      interfaceParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.double_click
    else
      interfaceParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.click
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

  def interfaceutilization_Quickfilter
    @browser.scroll.to :center
    interfaceParent.div(:class=>"dijitToolbar xwtContextualToolbar quickFilterExpanded").div(:class=>"dijitReset dijitRight dijitButtonNode dijitArrowButton dijitDownArrowButton dijitArrowButtonContainer icon-triangle icon-rotate-90").when_present.flash.click
    if $browser_type == :ie10
      interfaceParent.div(:class=>"dijitToolbar xwtContextualToolbar quickFilterExpanded").div(:class=>"dijitReset dijitRight dijitButtonNode dijitArrowButton dijitDownArrowButton dijitArrowButtonContainer icon-triangle icon-rotate-90").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    @browser.div(:class=>"dijitPopup dijitMenuPopup").tr(:index=>0).when_present.flash.click
    interface_name="GigabitEthernet2/1"
    interfaceParent.div(:class=>"table-head-node-container").div(:class=>"xwtFilterByExample").div(:class=>"cell-0").text_field(:class=>"dijitInputInner").when_present.set(interface_name)
    interfaceName=interfaceParent.div(:class=>"table-container").div(:class=>/row noSe/).table(:class,"row-table").tr.td(:class =>"cell-container",:index =>0).text
    if interface_name == interfaceName
      puts "Success-Quick Filter Functionality is working"
      return true
    else
      puts "Failure-Quick Filter Functionality is Not working"
      return false
    end
  end

  def interfcaeChart_XandY_AxisLabel
    self.chart_element.wd.location_once_scrolled_into_view
    xaxisActual=@browser.div(:class=>"chartNode").element(:text=>"Percentage").text
    yaxisActual=@browser.div(:class=>"chartNode").element(:text=>"Time Period").text
    if xaxisActual == "Percentage" && yaxisActual == "Time Period"
      puts "Success-The X-Axis and Y-Axis should have the expect title"
      return true
    else
      puts "Failure-The X and Y axis should not have the expect title"
      return false
    end
  end

  def interfaceTreandLineChart
    chartelement = []
    p =@browser.div(:class,"chartNode").element(:css => "svg").element(:css => "polyline")
    p.click
    all=@browser.div(:class=>"dijitTooltip xwtChartDatatip undefined").div(:class=>"dijitTooltipContents")
    chartelement << all.text
    puts "Tooltib Value: #{chartelement}"
    return chartelement
  end

  def interface_Inputilization
    chartelement = []
    all=@browser.div(:class=>"chartPanelHorizontalLegend").labels(:class=>"dojoxLegendText")
    all.map do |interface|
      chartelement << interface.text
    end
    puts "Tooltib Value: #{chartelement}"
    c=[]
    chartelement.each do |b|
      if b.include? "Output Utilization %"
        puts "Output Utilization % is displayed"
      else
        c = c<< b
        puts "Output Utilization % is not displayed"
      end
    end
    return c.size
  end

  def interface_Outputilization
    chartelement = []
    all=@browser.div(:class=>"chartPanelHorizontalLegend").labels(:class=>"dojoxLegendText")
    all.map do |interface|
      chartelement << interface.text
    end
    puts "Tooltib Value: #{chartelement}"
    c=[]
    chartelement.each do |b|
      if b.include? "Input Utilization %"
        puts "Input Utilization % is displayed"
      else
        c = c<< b
        puts "Input Utilization % is not displayed"
      end
    end
    return c.size
  end

  def inpututilization_CheckBox
    i=0
    all=@browser.div(:class=>"chartPanelHorizontalLegend").inputs(:class=>"dijitReset dijitCheckBoxInput")
    all.each do  |input|
      inputUtil=@browser.div(:class=>"chartPanelHorizontalLegend").input(:class=>"dijitReset dijitCheckBoxInput",:index=>i)
      sleep 3
      if inputUtil.present?
        inputUtil.click
        sleep 3
      else
        puts "Input Utilization checkbox not present"
      end
      i=i+2
    end
  end

  def outputilization_CheckBox
    i=1
    all=@browser.div(:class=>"chartPanelHorizontalLegend").inputs(:class=>"dijitReset dijitCheckBoxInput")
    all.each do  |input|
      outputUtil=@browser.div(:class=>"chartPanelHorizontalLegend").input(:class=>"dijitReset dijitCheckBoxInput",:index=>i)
      sleep 3
      if outputUtil.present?
        outputUtil.click
        sleep 3
      else
        puts "Output Utilization checkbox not present"
      end
      i=i+2
    end
  end

  def inpututilization_chart
    @browser.div(:class=>"chartNode").element(:css=>"svg").element(:css=>"polyline").click
    sleep 3
    #    tooltip=@browser.div(:class=>"dijitTooltip xwtChartDatatip undefined").div(:class=>"dijitTooltipContents").text
    #    sleep 2
    #    puts "All tooltip Input Value:#{tooltip}"
    #    if tooltip.include? "Input Utilization %"
    if @browser.div(:class=>"dijitTooltip xwtChartDatatip undefined").exists?
      puts "Input Utilization % is displayed"
      return true
    else
      puts "Input Utilization % is not displayed"
      return false
    end
  end

  def outpututilization_chart
    @browser.div(:class=>"chartNode").element(:css=>"svg").element(:css=>"polyline").click
    sleep 3
    #    tooltip=@browser.div(:class=>"dijitTooltip xwtChartDatatip undefined").div(:class=>"dijitTooltipContents").text
    #    sleep 2
    #    puts "All tooltip Output Value:#{tooltip}"
    #    if tooltip.include? "Output Utilization %"
    if @browser.div(:class=>"dijitTooltip xwtChartDatatip undefined").exists?
      puts "Output Utilization % is displayed"
      return true
    else
      puts "Output Utilization % is not displayed"
      return false
    end
  end

  def allInputOutputUtilization
    self.chartHorizontal_element.wd.location_once_scrolled_into_view
    self.allINOPCheckBox_element.click
    sleep 3
    self.allINOPCheckBox_element.click
    sleep 5
  end

  def particularInterfaceName_TrendLineChart

    i=0
    all=@browser.div(:class=>"chartPanelHorizontalLegend").inputs(:class=>"dijitReset dijitCheckBoxInput")
    all.each do  |input|
      outputUtil=@browser.div(:class=>"chartPanelHorizontalLegend").input(:class=>"dijitReset dijitCheckBoxInput",:index=>i)
      sleep 3
      if outputUtil.present?
        outputUtil.click
        sleep 3
      else
        puts "Output Utilization checkbox not present"
      end
      i=i+1
    end
    sleep 3
    @browser.div(:class=>"chartPanelHorizontalLegend").input(:class=>"dijitReset dijitCheckBoxInput",:index=>0).click
    @browser.div(:class=>"chartNode").element(:css=>"svg").element(:css=>"polyline").click
    sleep 3
    #    tooltip=@browser.div(:class=>"dijitTooltip xwtChartDatatip undefined").div(:class=>"dijitTooltipContents").text
    #    sleep 2
    #    puts "All tooltip Input Value:#{tooltip}"
    #    if tooltip.include? "Input Utilization %"
    if @browser.div(:class=>"dijitTooltip xwtChartDatatip undefined").exists?
      puts "Input Utilization % is displayed"
      return true
    else
      puts "Input Utilization % is not displayed"
      return false
    end
  end

  def columnSetting
    @browser.scroll.to :center
    if interfaceParent.div(:class=>"xwtGlobalToolbarActions").span(:class=>"dijitReset dijitStretch dijitButtonContents dijitDownArrowButton").flash.present?
      puts"Column Setting Button is displayed"
      return true
    else
      puts"Column Setting Button is not displayed"
      return false
    end
  end

  def interface_settingCehckTimeUtil50
    interfaceParent.div(:class=>"xwtGlobalToolbarActions").span(:class=>"dijitReset dijitStretch dijitButtonContents dijitDownArrowButton").when_present.flash.click
    self.column_element.when_present.flash.click
    @browser.div(:class=>"columnsContainerDiv").td(:text=>">50% Utilized (Greater Than 50 Percent Times Utilized)").when_present.flash.click
    self.close_element.when_present.flash.click
    if interfaceParent.div(:class=>"table-head-node-container").div(:text=>">50% Utilized").flash.present?
      puts "Success-The new column is added on interface utilization table"
      return true
    else
      puts "Failure-The new column is not added on interface utilization table"
      return false
    end
  end

  def interface_settingCehckTimeUtil75
    interfaceParent.div(:class=>"xwtGlobalToolbarActions").span(:class=>"dijitReset dijitStretch dijitButtonContents dijitDownArrowButton").when_present.flash.click
    self.column_element.when_present.flash.click
    @browser.div(:class=>"columnsContainerDiv").td(:text=>">75% Utilized (Greater Than 75 Percent Times Utilized)").when_present.flash.click
    self.close_element.when_present.flash.click
    if interfaceParent.div(:class=>"table-head-node-container").div(:text=>">75% Utilized").flash.present?
      puts "Success-The new column is added on interface utilization table"
      return true
    else
      puts "Failure-The new column is not added on interface utilization table"
      return false
    end
  end

  def interface_settingCehckTimeUtil90
    interfaceParent.div(:class=>"xwtGlobalToolbarActions").span(:class=>"dijitReset dijitStretch dijitButtonContents dijitDownArrowButton").when_present.flash.click
    self.column_element.when_present.flash.click
    @browser.div(:class=>"columnsContainerDiv").td(:text=>">90% Utilized (Greater Than 90 Percent Times Utilized)").when_present.flash.click
    self.close_element.when_present.flash.click
    if interfaceParent.div(:class=>"table-head-node-container").div(:text=>">90% Utilized").flash.present?
      puts "Success-The new column is added on interface utilization table"
      return true
    else
      puts "Failure-The new column is not added on interface utilization table"
      return false
    end
  end

  def interfaceDetailview_FilterOptionsTreanLine
    self.interface_global_filter
    interfaceParent.div(:class=>"table-container").wd.location_once_scrolled_into_view
    self.detail_calender_view
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"DetailLink").click
    sleep 10
    filterOptions=[]
    all=@browser.div(:id=>"filterDiv").trs
    all.map do |value|
      filterOptions<<value.span(:index=>0).flash.text
    end
    return filterOptions
  end

  def interfaceDetailview_TimePeriodSelection
    for i in 0..8
      @browser.div(:id=>"filterDiv").tr(:index=>0).div(:class=>"dijitDownArrowButton").flash.click
      #      @browser.div(:class=>"dijitPopup dijitComboBoxMenuPopup",:index=>0).li(:index=>i).flash.click
      @browser.div(:id=>"widget_timeRangeDropdown_dropdown",:index=>0).li(:index=>i).flash.click
      sleep 2
      if @browser.div(:id=>"filterDiv").tr(:index=>0).input(:id=>"timeRangeDropdown").present?
        actual=@browser.div(:id=>"filterDiv").tr(:index=>0).input(:id=>"timeRangeDropdown").flash.value
      end
    end
    puts "Time range value: #{actual}"
    return actual
  end

  def interfaceDetailview_FilterResetButton
    self.resetFilter_element.when_present.flash.click
    if @browser.div(:id=>"filterDiv").tr(:index=>0).input(:id=>"timeRangeDropdown").flash.value == "2 Weeks"
      puts "Reset functionality is working"
      return true
    else
      puts "Reset functionality is not working"
      return false
    end
  end

  def interfaceDetailview_FilterAppltCloseButton
    self.applyCloseFilter_element.when_present.flash.click
    if self.applyCloseFilter_element.present?
      puts "Apply And Close functionality is not working"
      return true
    else
      puts "Apply And Close functionality is working"
      return false
    end
  end

  def interfaceDetailview_ApplyButton
    self.filterArrow_element.when_present.flash.click
    sleep 2
    @browser.div(:id=>"filterDiv").tr(:index=>0).div(:class=>"dijitDownArrowButton").flash.click
#    @browser.div(:class=> "dijitPopup dijitComboBoxMenuPopup",:index=>0).li(:index=>3).flash.click
    @browser.div(:id=>"widget_timeRangeDropdown_dropdown",:index=>0).li(:index=>3).flash.click
    self.applyFilter_element.when_present.flash.click
    sleep 3
    if @browser.div(:class=>"chartNode").present?
      puts "Apply functionality is  working"
      return true
    else
      puts "Apply functionality is not working"
      return false
    end
  end

  def interfaceDetailview_ByGroup(indValueA,checkboxitem,indValueB)
    puts indValueA
    puts checkboxitem
    puts indValueB
    @browser.div(:id=>"filterDiv").tr(:index=>indValueA).div(:class=>"dijitDownArrowButton").flash.click
    sleep 3
    #    @browser.div(:class=>"xwtObjectSelectorIconTableNormal icon-list-view",:index=>indValueB).flash.click
    @browser.div(:class=>"osItemRightArea",:index=>indValueB).flash.click
    #    @browser.div(:class=>"dijitTreeContainer",:index=>1).span(:class=>"dijitTreeExpando").flash.click
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog xwt_BasePickerPopover dijitTooltipABLeft dijitTooltipBelow").id
    p popid
    avala = popid.scan(/[0-9#]+/i)
    a = avala[0]
    popvala = a.to_i
    @browser.div(:id,"#{popid}").div(:id,"xwt_widget_form_ObjectSelectorMultiPicker_#{popvala}_buttonContainer").span(:text=>"Clear Selections").flash.click

    if $browser_type == :ie10
      @browser.div(:id,"#{popid}").div(:class=>"xwtObjectSelectorListText",:text=>"#{checkboxitem}").parent.checkbox.click
    else
      @browser.div(:id,"#{popid}").div(:class=>"xwtObjectSelectorListText",:text=>"#{checkboxitem}").parent.checkbox.fire_event('onclick')
    end

    if @browser.div(:id,"#{popid}").div(:class=>"xwtObjectSelectorListText",:text=>"#{checkboxitem}").parent.checkbox.checked?
      @browser.div(:id,"#{popid}").div(:id,"xwt_widget_form_ObjectSelectorMultiPicker_#{popvala}_buttonContainer").span(:text=>"Cancel").flash.click
      return true
    else
      return false
    end
  end

  def interfaceDetailview_Device
    @browser.div(:id=>"filterDiv").tr(:index=>2).div(:class=>"dijitDownArrowButton").flash.click
    sleep 3
    #    @browser.div(:class=>"xwtObjectSelectorIconTableNormal icon-list-view",:index=>2).flash.click
    clickcheck=@browser.div(:class=>"osItemRightArea",:index=>2)
    #    @browser.div(:class=>"dijitTreeContainer",:index=>1).span(:class=>"dijitTreeExpando").flash.click
    if @browser.div(:class=>"xwtPopover dijitTooltipDialog xwt_BasePickerPopover dijitTooltipABLeft dijitTooltipBelow").exists?
      return true
    else
      return false
    end
  end

  def interfaceDetailview_Interface
    @browser.div(:id=>"filterDiv").tr(:index=>3).div(:class=>"dijitDownArrowButton").flash.click
    sleep 3
    #    @browser.div(:class=>"xwtObjectSelectorIconTableNormal icon-list-view",:index=>2).flash.click
    clickcheck=@browser.div(:class=>"osItemRightArea",:index=>3)
    if @browser.div(:class=>"xwtPopover dijitTooltipDialog xwt_BasePickerPopover dijitTooltipABLeft dijitTooltipBelow").exists?
      return true
    else
      return false
    end
  end

  def interfaceDetailview_InterfaceGroup
    @browser.div(:id=>"filterDiv").tr(:index=>1).div(:class=>"dijitRadio",:index=>1).flash.click
    clickPopup=@browser.div(:id=>"filterDiv").tr(:index=>1).div(:class=>"dijitDownArrowButton",:index=>1).flash.click
    if @browser.div(:class=>"xwtPopover dijitTooltipDialog xwt_BasePickerPopover dijitTooltipABLeft dijitTooltipBelow").exists?
      return true
    else
      return false
    end
  end

  def detailview_InterfaceGroupRadioButtonSelection
    location=@browser.div(:id=>"filterDiv").tr(:index=>1).div(:class=>"xwt_BasePicker dijitDisabled")
    device=@browser.div(:id=>"filterDiv").tr(:index=>2).div(:class=>"xwt_BasePicker dijitDisabled")
    if location.present? && device.present?
      @browser.div(:id=>"filterDiv").tr(:index=>1).div(:class=>"dijitRadio",:index=>0).flash.click
      return true
    else
      return false
    end
  end

  def interfaceDetailview_TreandLinear
    @browser.div(:id=>"filterDiv").tr(:index=>7).div(:class=>"dijitDownArrowButton").flash.click
#    trendList=@browser.div(:class=>"dijitPopup dijitComboBoxMenuPopup").li(:text=>"Linear Regression")
    actual=@browser.div(:id=>"trendModelDropdown_popup").li(:text=>"Linear Regression").text
    @browser.div(:id=>"trendModelDropdown_popup").li(:text=>"Linear Regression").flash.click
    sleep 3
    expect=@browser.div(:id=>"filterDiv").tr(:index=>7).input(:id=>"trendModelDropdown").value
    if actual == expect
      puts"Success-The Treand is selected"
      return true
    else
      puts"Failure-The Treand is Not Selected"
      return false
    end
  end

  def interfaceDetailview_TreandChart
    self.applyFilter_element.when_present.click
    @browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"chartNode").wd.location_once_scrolled_into_view
    sleep 5
    output=[]
    @browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"chartNode").element(:tag_name=> "polyline").click
    sleep 2
    @browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"chartNode").element(:tag_name=> "polyline").click
    puts "after click"
    output<<@browser.div(:id =>"xwt_widget_charting_widget__MasterDatatip_0").div(:class =>"dijitTooltipContainer dijitTooltipContents").text
    puts output
    return output
  end

  def interfaceDetailview_Treand(trendList)
    puts trendList
    @browser.div(:id=>"filterDiv").tr(:index=>7).div(:class=>"dijitDownArrowButton").flash.click
    @browser.div(:id=>"widget_trendModelDropdown_dropdown").li(:text=>"#{trendList}").flash.click
    self.interfaceDetailview_TreandChart
  end

  def interfaceDetailviewPage
    interfaceParent.div(:class=>"table-container").wd.location_once_scrolled_into_view
    self.detail_calender_view
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"DetailLink").click
  end

  def interfaceDetailview_InputUtilCheckBoxEnableDiableChart(trendList)

    @browser.div(:id=>"filterDiv").tr(:index=>7).div(:class=>"dijitDownArrowButton").flash.click
#    @browser.div(:class=>"dijitPopup dijitComboBoxMenuPopup").li(:text=>"#{trendList}").click
    @browser.div(:id=>"trendModelDropdown_popup").li(:text=>"#{trendList}").click
    self.applyFilter_element.when_present.click
    @browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"chartNode").wd.location_once_scrolled_into_view
    @browser.div(:class=>"chartPanelHorizontalLegend").input(:class=>"dijitReset dijitCheckBoxInput",:index=>0).click
    @browser.div(:class=>"chartPanelHorizontalLegend").input(:class=>"dijitReset dijitCheckBoxInput",:index=>1).click
    sleep 3
    outputUtilValue=[]
    @browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"chartNode").element(:tag_name=> "polyline").click
    sleep 2
    @browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"chartNode").element(:tag_name=> "polyline").click
    puts "after click"
    outputUtilValue=@browser.div(:id =>"xwt_widget_charting_widget__MasterDatatip_0").div(:class =>"dijitTooltipContainer dijitTooltipContents").text
    puts "outputUtilValue: #{outputUtilValue}"
#    if outputUtilValue.include? "Output Utilization %"
    if @browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"chartNode").element(:tag_name=> "polyline").present?
      puts"Input Utilization % Value is displayed Chart"
      return true
    else
      puts"Input Utilization % Value is Not displayed in Chart"
      return false
    end
  end

  def interfaceDetailview_OutputUtilCheckBoxEnableDiableChart
    @browser.div(:class=>"chartPanelHorizontalLegend").input(:class=>"dijitReset dijitCheckBoxInput",:index=>0).click
    @browser.div(:class=>"chartPanelHorizontalLegend").input(:class=>"dijitReset dijitCheckBoxInput",:index=>1).click
    @browser.div(:class=>"chartPanelHorizontalLegend").input(:class=>"dijitReset dijitCheckBoxInput",:index=>2).click
    @browser.div(:class=>"chartPanelHorizontalLegend").input(:class=>"dijitReset dijitCheckBoxInput",:index=>3).click
    sleep 5
    inputUtilValue=[]
    @browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"chartNode").element(:tag_name=> "polyline").click
    sleep 2
    @browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"chartNode").element(:tag_name=> "polyline").click
    puts "after click"
    inputUtilValue=@browser.div(:id =>"xwt_widget_charting_widget__MasterDatatip_0").div(:class =>"dijitTooltipContainer dijitTooltipContents").text
    puts "inputUtilValue: #{inputUtilValue}"
#    if inputUtilValue.include? "Input Utilization %"
    if @browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"chartNode").element(:tag_name=> "polyline").present?
      puts"Output Utilization % Value is displayed Chart"
      return true
    else
      puts"Output Utilization % Value is Not displayed in Chart"
      return false
    end
  end

  def interfaceDetailview_AllDuration(ind)
    puts ind
    @browser.div(:id=>"filterDiv").tr(:index=>0).div(:class=>"dijitDownArrowButton").flash.click
    @browser.div(:id=>"widget_timeRangeDropdown_dropdown").li(:index=>ind).flash.click
  end
  
##Cal View functions start

  def interfaceUtilCalview_launch
    @browser.scroll.to :center
    interface_name="GigabitEthernet"
    interfaceParent.div(:class=>"table-head-node-container").div(:class=>"xwtFilterByExample").div(:class=>"cell-0").text_field(:class=>"dijitInputInner").when_present.set(interface_name)
    sleep 8
    if $browser_type == :ie10
      interfaceParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.double_click
    else
      interfaceParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.click
    end
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"CalenderLink").when_present.flash.click
    sleep 10
    actual=self.pageTitle_element.flash.text
    puts "actual : #{actual}"
    return actual
  end

  def interfaceUtilCalview_hourlyFilter
    self.filterDiv_element.flash
    if self.radio_hourly_element.checked?
      puts"Already Checked"
    else
      self.radio_hourly_element.click
      self.apply_filter_element.flash.click
      sleep 3
    end
  end

  def interfaceUtilCalview_dailyFilter
    self.filterDiv_element.flash
    if self.radio_daily_element.checked?
      puts"Already Checked"
    else
      self.radio_daily_element.click
      self.apply_filter_element.flash.click
      sleep 3
    end
  end

  def interfaceUtilCalview_xlabel
    tooltip_text = @browser.elements(:class=>"xlabel").map do |slice|
      slice.text
    end
    p tooltip_text
    return tooltip_text
  end

  def  interfaceUtilCalview_ylabel
    tooltip_text = @browser.elements(:class=>"ylabel").map do |slice|
      slice.text
    end
    p tooltip_text
    arr=tooltip_text

    if (arr[0] =~ /^[a-z]+\s\d{2}\,\s\d{4}$/i)
      puts "Hourly Data"
      actual_ylabel = 'Hourly Data'
      return actual_ylabel
    elsif (arr[0] =~ /^[a-z]+\s\d{4}$/i)
      puts "Daily Data"
      actual_ylabel = 'Daily Data'
      return actual_ylabel
    else
      puts "Wrong Data"
    end
  end

  def interfaceUtilCalview_cellData
    actual = []
    p = @browser.div(:id=>"cellDateTip").table.tr(:index=>1).tds(:class=>"CellTooltipColumn1")

    p.each do |column|
      actual<< column.text
    end

    p = @browser.div(:id=>"cellDateTip").table.tr(:index=>2).tds(:class=>"CellTooltipColumn1")
    p.each do |column|
      actual<< column.text
    end

    puts "Actual: #{actual}"
    return actual
  end

  def interfaceUtilCalview_cellColor
    self.interfaceUtilCalview_hourlyFilter
    val1=@browser.element(:tag_name=>"rect").style("stroke")
    puts "Value1: #{val1}"
    @browser.element(:tag_name=>"rect").click
    val2=@browser.div(:id=>"cellDateTip").table.tr(:index=>1).td(:class=>"CellTooltipColumn2").style("color")
    puts "Value2: #{val2}"

    val1=~ /rgb\((\d+)\,\s(\d+)\,\s(\d+)\)/
    red1 = $1
    grn1 = $2
    blu1 = $3

    val2=~ /rgba\((\d+)\,\s(\d+)\,\s(\d+)\,\s(\d+)\)/
    red2 = $1
    grn2 = $2
    blu2 = $3

    if (red1 == red2) && (grn1 == grn2) && (blu1 == blu2)
      puts "success"
      return true
    else
      puts "fail"
      return false
    end
  end

  def interfaceUtilCalview_cellbelowData
    @browser.element(:tag_name=>"rect").click
    self.interfaceUtilCalview_cellData
  end

  def interfaceUtilCalview_cellTooltip
    cal_cell=@browser.element(:tag_name=>"rect")
    cal_cell.hover
    tooltip_text= @browser.div(:id=>"dijit__MasterTooltip_0").div(:class, 'dijitTooltipContents').text
    puts "HERE: #{tooltip_text}"
    if tooltip_text =~ (/Status(.*)\nUtilization(.*)/)
      puts "Correct tooltip"
      return true
    else
      puts "Incorrect tooltip"
      return false
    end
  end

  def interfaceUtilCalview_legend
    actual=[]
    i=0
    all=@browser.element(:class=>"legendGroup").elements(:class=>"legendItems")
    all.each do |column|
      actual << @browser.element(:class=>"legendGroup").element(:class=>"legendItems",:index=>i).element(:tag_name=>"rect").style("fill")
      actual << @browser.element(:class=>"legendGroup").element(:class=>"legendItems",:index=>i).element(:tag_name=>"text").text
      i=i+1
    end
    puts "Actual: #{actual}"
    return actual
  end

  def interfaceUtilCalview_patterns
    self.chartactIcon_element.click
    self.showpatt_element.click
    actual=[]
    i=0
    all=@browser.element(:class=>"legendGroup").elements(:class=>"legendItems")
    all.each do |column|
      actual << @browser.element(:class=>"legendGroup").element(:class=>"legendItems",:index=>i).element(:class=>"fillPattern").attribute_value("d")
      actual << @browser.element(:class=>"legendGroup").element(:class=>"legendItems",:index=>i).element(:tag_name=>"rect").style("fill")
      actual << @browser.element(:class=>"legendGroup").element(:class=>"legendItems",:index=>i).element(:tag_name=>"text").text
      i=i+1
    end
    self.chartactIcon_element.click
    self.showpatt_element.click
    puts "Actual: #{actual}"
    return actual
  end

  def interfaceUtilCalview_helpIcon
    self.globaltooltip_element.hover
    tooltip_text= @browser.div(:id=>"dijit__MasterTooltip_0").div(:class, 'dijitTooltipContents').text
    puts "Actual: #{tooltip_text}"
    return tooltip_text
  end

  def interfaceUtilCalview_tableView
    self.table_Icon_element.click
    if @browser.div(:class=>"dojoxGridContent").present?
      self.chart_Icon_element.click
      return true
    else
      return false
    end
  end

  def interfaceUtilCalview_sitefilter
    self.chart_Icon_element.click
    self.radio_siteselect_element.click
    if @browser.div(:class=>"filterDiv").table.tr(:index=>2).div(:class=>"dijitDisabled").present?
      return true
    else
      return false
    end
  end

  def interfaceUtilCalview_iffilter
    self.radio_ifselect_element.click
    if @browser.div(:class=>"filterDiv").table.tr(:index=>1).div(:class=>"dijitDisabled").present? && @browser.div(:class=>"filterDiv").table.tr(:index=>1).div(:class=>"dijitDisabled").present?
      return true
    else
      return false
    end
  end

  def interfaceUtilCalview_sitesingle
    self.radio_siteselect_element.click
    @browser.div(:class=>"filterDiv").table.tr(:index=>1).div(:class=>"dijitDownArrowButton").flash.click
    @browser.div(:class=>"osItemRightArea",:index=>0).flash.click
    @browser.span(:text=>"Clear Selections",:index=>0).flash.click
    @browser.div(:class=>"xwtObjectSelectorListText",:text=>"San Jose").parent.checkbox.flash.click
    @browser.span(:text=>"OK",:index=>0).flash.click
    self.apply_filter_element.click
    location= @browser.div(:class=>"filterDiv").table.tr(:index=>1).div(:class=>"xwt_BasePickerDisplayBox").text
    puts "Location: #{location}"
    sleep 3
    if location == 'San Jose' && @browser.element(:tag_name=>"svg").present?
      puts "coming here"
      return true
    else
      puts "Not coming"
      return false
    end
  end

  def interfaceUtilCalview_sitemultiple
    @browser.div(:class=>"filterDiv").table.tr(:index=>1).div(:class=>"dijitDownArrowButton").flash.click
    @browser.div(:class=>"osItemRightArea",:index=>0).flash.click
    @browser.span(:text=>"Clear Selections",:index=>0).flash.click
    @browser.div(:class=>"xwtObjectSelectorListText",:text=>"San Jose").parent.checkbox.flash.click
    @browser.div(:class=>"xwtObjectSelectorListText",:text=>"India").parent.checkbox.flash.click
    @browser.span(:text=>"OK",:index=>0).flash.click
    self.apply_filter_element.click
    location= @browser.div(:class=>"filterDiv").table.tr(:index=>1).div(:class=>"xwt_BasePickerDisplayBox").text
    puts "Location: #{location}"
    sleep 3
    if location == 'Multiple selections' && @browser.element(:tag_name=>"svg").present?
      puts "coming here"
      return true
    else
      puts "Not coming"
      return false
    end
  end

  def interfaceUtilCalview_ifgrpsingle
    self.radio_ifselect_element.click
    @browser.div(:class=>"filterDiv").table.tr(:index=>2).div(:class=>"dijitDownArrowButton").flash.click
    @browser.div(:class=>"osItemRightArea",:index=>1).flash.click
    @browser.span(:text=>"Clear Selections",:index=>1).flash.click
    @browser.div(:class=>"xwtObjectSelectorListText",:text=>"System Defined").parent.checkbox.flash.click
    @browser.span(:text=>"OK",:index=>1).flash.click
    self.apply_filter_element.click
    ifgrp= @browser.div(:class=>"filterDiv").table.tr(:index=>2).div(:class=>"xwt_BasePickerDisplayBox").text
    puts "IfGrp: #{ifgrp}"
    sleep 3
    if ifgrp == 'System Defined' && @browser.element(:tag_name=>"svg").present?
      puts "coming here"
      return true
    else
      puts "Not coming"
      return false
    end
  end

  def interfaceUtilCalview_deviceall
    self.radio_siteselect_element.click
    @browser.div(:class=>"filterDiv").table.tr(:index=>3).div(:class=>"dijitDownArrowButton").flash.click

    if @browser.div(:class=>"dijitTreeContainer",:index=>1).span(:class=>"dijitTreeExpandoOpened").present?
      puts "Expando Opened Already"
    else
      @browser.div(:class=>"dijitTreeContainer",:index=>1).span(:class=>"dijitTreeExpando").click
    end

    @browser.span(:text=>"Clear Selections",:index=>2).flash.click
    @browser.span(:text=>"All").parent.checkbox.flash.click
    @browser.span(:text=>"OK",:index=>2).flash.click
    self.apply_filter_element.click
    device= @browser.div(:class=>"filterDiv").table.tr(:index=>3).div(:class=>"xwt_BasePickerDisplayBox").text
    puts "Device: #{device}"
    sleep 3
    if device == 'All' && @browser.element(:tag_name=>"svg").present?
      puts "coming here"
      return true
    else
      puts "Not coming"
      return false
    end
  end

  def interfaceUtilCalview_devicesingle
    @browser.div(:class=>"filterDiv").table.tr(:index=>3).div(:class=>"dijitDownArrowButton").flash.click

    if @browser.div(:class=>"dijitTreeContainer",:index=>1).span(:class=>"dijitTreeExpandoOpened").present?
      puts "Expando Opened Already"
    else
      @browser.div(:class=>"dijitTreeContainer",:index=>1).span(:class=>"dijitTreeExpando").click
    end

    @browser.span(:text=>"Clear Selections",:index=>2).flash.click
    @browser.span(:text=>"4506_switch_top.cisco.com").parent.checkbox.flash.click
    @browser.span(:text=>"sjc-7200-2.cisco.com").parent.checkbox.flash.click  ##Workaround-Line1
    @browser.span(:text=>"4506_switch_top.cisco.com").parent.checkbox.flash.click ##Workaround-Line2
    @browser.span(:text=>"OK",:index=>2).flash.click
    self.apply_filter_element.click
    device= @browser.div(:class=>"filterDiv").table.tr(:index=>3).div(:class=>"xwt_BasePickerDisplayBox").text
    puts "Device: #{device}"
    sleep 3
    if device == 'sjc-7200-2.cisco.com' && @browser.element(:tag_name=>"svg").present?
      puts "coming here"
      return true
    else
      puts "Not coming"
      return false
    end
  end

  def interfaceUtilCalview_devicemultiple
    @browser.div(:class=>"filterDiv").table.tr(:index=>3).div(:class=>"dijitDownArrowButton").flash.click

    if @browser.div(:class=>"dijitTreeContainer",:index=>1).span(:class=>"dijitTreeExpandoOpened").present?
      puts "Expando Opened Already"
    else
      @browser.div(:class=>"dijitTreeContainer",:index=>1).span(:class=>"dijitTreeExpando").click
    end

    @browser.span(:text=>"Clear Selections",:index=>2).flash.click
    @browser.span(:text=>"4506_switch_top.cisco.com").parent.checkbox.flash.click
    @browser.span(:text=>"sjc-7200-2.cisco.com").parent.checkbox.flash.click
    @browser.span(:text=>"4506_switch_top.cisco.com").parent.checkbox.flash.click ##Workaround-Line1
    @browser.span(:text=>"DAL-3945-1").parent.checkbox.flash.click  ##Workaround-Line2
    @browser.span(:text=>"OK",:index=>2).flash.click
    self.apply_filter_element.click
    device= @browser.div(:class=>"filterDiv").table.tr(:index=>3).div(:class=>"xwt_BasePickerDisplayBox").text
    puts "Device: #{device}"
    sleep 3
    if device == 'Multiple selections' && @browser.element(:tag_name=>"svg").present?
      puts "coming here"
      return true
    else
      puts "Not coming"
      return false
    end
  end

  def interfaceUtilCalview_ifsingle
    self.radio_ifselect_element.click
    @browser.div(:class=>"filterDiv").table.tr(:index=>4).div(:class=>"dijitDownArrowButton").flash.click
    @browser.span(:title=>"GigabitEthernet2/1@4506_switch_top.cisco.com").flash.click
    @browser.div(:class=>"filterDiv").table.tr(:index=>4).div(:class=>"dijitDownArrowButton").flash.click
    @browser.span(:title=>"GigabitEthernet0/1@sjc-7200-2.cisco.com").flash.click
    self.apply_filter_element.click
    interface= @browser.div(:class=>"filterDiv").table.tr(:index=>4).div(:class=>"xwt_BaseSinglePickerROField").text
    puts "Interface: #{interface}"
    sleep 3
    if interface == 'GigabitEthernet0/1@sjc-7200-2.cisco.com' && @browser.element(:tag_name=>"svg").present?
      puts "coming here"
      return true
    else
      puts "Not coming"
      return false
    end
  end

  def interfaceUtilCalview_ifselect
    @browser.div(:class=>"filterDiv").table.tr(:index=>4).div(:class=>"dijitDownArrowButton").flash.click
    @browser.span(:title=>"GigabitEthernet2/1@4506_switch_top.cisco.com").flash.click
    self.apply_filter_element.click
    interface= @browser.div(:class=>"filterDiv").table.tr(:index=>4).div(:class=>"xwt_BaseSinglePickerROField").text
    puts "Interface: #{interface}"
    sleep 3
    if interface == 'GigabitEthernet2/1@4506_switch_top.cisco.com' && @browser.element(:tag_name=>"svg").present?
      puts "coming here"
      return true
    else
      puts "Not coming"
      return false
    end
  end

  def interfaceUtilCalview_ExportCSV
    @browser.div(:class=>"bottomIcons").div(:class=>"chartMoreActionIcon").flash.click
    @browser.div(:class=>"xwtMoreActionPopup").div(:class=>"actionDropDownItem",:title=>"Export").flash.click
    ind=0
    until @browser.div(:id=>"xwt_widget_form_TextButtonGroup_#{ind}").present?
      puts ind
      ind = ind + 1
    end
    @browser.div(:id=>"xwt_widget_form_TextButtonGroup_#{ind}").span(:text=>"Export").when_present.flash.click
    sleep 15
    last_csv_file = on_page(GlobalPage).get_last_created($download_directory)
    puts "fdsfsdfsdfsdfsdfdsfdsfsdfsdfsd",last_csv_file.path
    csv_file = File.read(last_csv_file)
    csv_data = CSV.parse(csv_file)
    csv_values = Array.new
    csv_data.each do  |row|
      puts row.inspect
      csv_values << row
    end
    return csv_values
  end

  ##Cal View functions end

  def ifutil_columns_50
    @browser.scroll.to :center
    interfaceParent.div(:class=>"xwtGlobalToolbarActions").span(:class=>"dijitReset dijitStretch dijitButtonContents dijitDownArrowButton").when_present.flash.click
    self.column_element.when_present.flash.click
    if @browser.div(:class=>"columnsContainerDiv").td(:text=>">50% In Utilized (Greater Than 50 Percent Times Input Utilized)").present? && @browser.div(:class=>"columnsContainerDiv").td(:text=>">50% In Utilized (Greater Than 50 Percent Times Input Utilized)").present?
      return true
    else
      return false
    end
  end

  def ifutil_columns_75
    if @browser.div(:class=>"columnsContainerDiv").td(:text=>">75% In Utilized (Greater Than 75 Percent Times Input Utilized)").present? && @browser.div(:class=>"columnsContainerDiv").td(:text=>">75% Out Utilized (Greater Than 75 Percent Times Output Utilized)").present?
      return true
    else
      return false
    end
  end

  def ifutil_columns_90
    if @browser.div(:class=>"columnsContainerDiv").td(:text=>">90% In Utilized (Greater Than 90 Percent Times Input Utilized)").present? && @browser.div(:class=>"columnsContainerDiv").td(:text=>">90% Out Utilized (Greater Than 90 Percent Times Output Utilized)").present?
      return true
    else
      return false
    end
  end

  def ifutil_columnorder
    @browser.span(:text=>"Reset").flash.click
    interfaceParent.div(:class=>"xwtGlobalToolbarActions").span(:class=>"dijitReset dijitStretch dijitButtonContents dijitDownArrowButton").when_present.flash.click
    arr=[5,6,9,12,15]
    actual=[]
    for i in (arr)
      actual << interfaceParent.div(:class=>"table-head-node-container").td(:class=>"cell-container",:index=>i).text
    end
    puts "Columns: #{actual}"
    return actual
  end

  def ifdv_absolutemode
    interface_name="GigabitEthernet"
    interfaceParent.div(:class=>"table-head-node-container").div(:class=>"xwtFilterByExample").div(:class=>"cell-0").text_field(:class=>"dijitInputInner").when_present.set(interface_name)
    sleep 8
    if $browser_type == :ie10
      interfaceParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.double_click
    else
      interfaceParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.click
    end
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"DetailLink").when_present.flash.click
    sleep 10
    if @browser.radio(:value=>"absoluteMode").checked?
      puts "Already AbsoluteMode Checked"
    else
      @browser.radio(:value=>"absoluteMode").click
    end
    if @browser.div(:class=>"filterDiv").tr(:index=>5).div(:class=>"dijitCheckBox dijitCheckBoxDisabled",:index=>0).present? &&
    @browser.div(:class=>"filterDiv").tr(:index=>5).div(:class=>"dijitCheckBox dijitCheckBoxDisabled",:index=>1).present? &&
    @browser.div(:class=>"filterDiv").tr(:index=>5).div(:class=>"dijitCheckBox dijitCheckBoxDisabled",:index=>2).present? &&
    @browser.div(:class=>"filterDiv").tr(:index=>5).div(:class=>"dijitCheckBox dijitCheckBoxDisabled",:index=>3).present?
      return true
    else
      return false
    end
  end

  def ifdv_percentmode
    if @browser.radio(:value=>"percentMode").checked?
      puts "Already PercentMode Checked"
    else
      @browser.radio(:value=>"percentMode").click
    end
    if @browser.div(:class=>"filterDiv").tr(:index=>5).div(:class=>"dijitCheckBox dijitCheckBoxDisabled",:index=>0).present? &&
    @browser.div(:class=>"filterDiv").tr(:index=>5).div(:class=>"dijitCheckBox dijitCheckBoxDisabled",:index=>1).present? &&
    @browser.div(:class=>"filterDiv").tr(:index=>5).div(:class=>"dijitCheckBox dijitCheckBoxDisabled",:index=>2).present? &&
    @browser.div(:class=>"filterDiv").tr(:index=>5).div(:class=>"dijitCheckBox dijitCheckBoxDisabled",:index=>3).present?
      return false
    else
      return true
    end
  end

  def qosParent
    ind = 0
    while ! @browser.div(:id,"xwt_widget_layout_TabContentPane_#{ind}").present?
      puts ind
      ind = ind + 1
    end
    @browser.div(:id,"xwt_widget_layout_TabContentPane_#{ind}")
  end

  def qosdv_graphview
    navigate_application_to "Home"
    new_tab = "QoS Classes"
    self.select_dashboard_tab(new_tab)
    qosParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon",:index=>1).when_present(5).flash.click
    sleep 2
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"DetailLink").when_present(5).flash.click
    if @browser.div(:class=>"filterDiv").tr(:index=>5).label(:text=>"Individual").present? && @browser.div(:class=>"filterDiv").tr(:index=>5).label(:text=>"Merged").present?
      return true
    else
      return false
    end
  end

  def qosdv_individual
    if @browser.div(:class=>"filterDiv").tr(:index=>5).radio(:value=>"unmerged").checked?
      puts "Individual already checked"
    else
      @browser.div(:class=>"filterDiv").tr(:index=>5).radio(:value=>"unmerged").click
      span(:id=>"applyBt_label").flash.click
      sleep 3
    end
    prepolicy=@browser.div(:class=>"evenLevelTitlePane",:index=>1).div(:class=>"xwtTitlePaneTextNode").text
    puts "Prepolicy: #{prepolicy}"
    postpolicy=@browser.div(:class=>"evenLevelTitlePane",:index=>2).div(:class=>"xwtTitlePaneTextNode").text
    puts "Postpolicy: #{postpolicy}"
    drop=@browser.div(:class=>"evenLevelTitlePane",:index=>3).div(:class=>"xwtTitlePaneTextNode").text
    puts "Drop: #{drop}"
    if (prepolicy =~ /(.*)AvgPrePolicyOctetsRate \(Bps\)/) && (postpolicy =~ /(.*)AvgPostPolicyOctetsRate \(Bps\)/) && (drop =~ /(.*)AvgDropOctetsRate \(Bps\)/)
      return true
    else
      return false
    end
  end

  def qosdv_merged
    if @browser.div(:class=>"filterDiv").tr(:index=>5).radio(:value=>"merged").checked?
      puts "Individual already checked"
    else
      @browser.div(:class=>"filterDiv").tr(:index=>5).radio(:value=>"merged").click
      @browser.span(:id=>"applyBt_label").flash.click
      sleep 3
    end
    policyrate=@browser.div(:class=>"evenLevelTitlePane",:index=>1).div(:class=>"xwtTitlePaneTextNode").text
    puts "Policyrate: #{policyrate}"
    if policyrate == 'Qos Classes Graph'
      return true
    else
      return false
    end
  end

  def savedreport_nametitle
    navigate_application_to "Report=>Saved Reports"
    actual = @browser.div(:class=>"cellHeaderWrapper",:index=>1).text
    if actual == 'Name'
      return true
    else
      return false
    end
  end

  def savedreport_columnfilter
    @browser.span(:class=>"dijitDownArrowButton",:title=>"Settings").flash.click
    self.column_element.when_present.flash.click
    actual = @browser.div(:class=>"columnsContainerDiv").td(:class=>"dijitMenuItemLabel",:index=>4).text
    if actual == 'Filter'
      return true
    else
      return false
    end
  end

  def ifutil_topnchartqv_launch
    until @browser.element(:tag_name=>"svg").element(:tag_name=>"path").present?
      @browser.element(:tag_name=>"svg").element(:tag_name=>"polyline").click
      puts "Coming here"
    end
    @browser.element(:tag_name=>"svg").element(:tag_name=>"path").click
    if @browser.div(:class=>"dijitTooltipDialogPopup").div(:class=>"dijitTooltipContainer").present?
      return true
    else
      return false
    end
  end

  def ifutil_topnchartqv_grid
    @browser.div(:class=>"tableIcon",:index=>1).click
    if @browser.div(:class=>"dijitTooltipDialogPopup").div(:class=>"dojoxGridRow").present?
      @browser.div(:class=>"tableIcon",:index=>1).click
      return true
    else
      return false
    end
  end

  def ifutil_topnchartqv_gridsort
    uiall = []
    uiall = @browser.div(:class=>"dijitTooltipDialogPopup").div(:class=>"dojoxGridContent").divs(:class=>"dojoxGridRow")
    unsorted = []
    uiall.each do |p|
      p.table(:class,"dojoxGridRowTable").tr.td(:class => /dojoxGridCell/, :index => 1).flash
      unsorted << p.table(:class,"dojoxGridRowTable").tr.td(:class => /dojoxGridCell/, :index => 1).text.scan(/[0-9#]+/i)
    end
    ascendingsort  = unsorted.sort {|x, y| x <=> y}
    puts "Ascending", ascendingsort
    descendingsort = unsorted.sort! {|x, y| y <=> x}
    puts "Descending", descendingsort
    @browser.div(:class=>"dijitTooltipDialogPopup").div(:class=>"dojoxGridMasterHeader").th(:class=>"dojoxGridCell dojoDndItem",:index=>1).when_present.flash.click
    uiall = @browser.div(:class=>"dijitTooltipDialogPopup").div(:class,"dojoxGridContent").divs(:class,/dojoxGridRow/)
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
    @browser.div(:class=>"dijitTooltipDialogPopup").div(:class=>"dojoxGridMasterHeader").th(:class=>"dojoxGridCell dojoDndItem",:index=>1).when_present.flash.click
    uiall = @browser.div(:class=>"dijitTooltipDialogPopup").div(:class,"dojoxGridContent").divs(:class,/dojoxGridRow/)
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

  def ifutil_topnchart_exportcsv
    @browser.div(:class=>"chartMoreActionIcon",:index=>2).click
    @browser.div(:text=>"Export",:index=>0).click
    ind=0
    until @browser.div(:id=>"xwt_widget_form_TextButtonGroup_#{ind}").present?
      puts ind
      ind = ind + 1
    end
    @browser.div(:id=>"xwt_widget_form_TextButtonGroup_#{ind}").span(:text=>"Export").when_present.flash.click
    sleep 15
    last_csv_file = on_page(GlobalPage).get_last_created($download_directory)
    puts "fdsfsdfsdfsdfsdfdsfdsfsdfsdfsd",last_csv_file.path
    csv_file = File.read(last_csv_file)
    csv_data = CSV.parse(csv_file)
    csv_values = Array.new
    csv_data.each do  |row|
      puts row.inspect
      csv_values << row
    end
    return csv_values
  end

  def ifutil_topnchart_schdrpt
    @browser.div(:class=>"chartMoreActionIcon",:index=>2).click
    @browser.div(:text=>"Schedule Report",:index=>0).click
    self.schedule_report
  end

  def ifutil_topnchart_calview
    @browser.div(:class=>"CalenderLink").when_present.flash.click
    sleep 10
    actual=self.pageTitle_element.flash.text
    puts "actual : #{actual}"
    return actual
  end

  def ifutil_table_title
    navigate_application_to "Home"
    sleep 5
    title = interfaceParent.div(:class=>"table-head-node-container").td(:class=>"cell-container").title
    if title == 'Interface Name: Sortable' || title == 'Interface Name: Currently Sorted'
      return true
    else
      return false
    end
  end

  def ifutil_topnchart_detailview
    until @browser.element(:tag_name=>"svg").element(:tag_name=>"path").present?
      @browser.element(:tag_name=>"svg").element(:tag_name=>"polyline").click
      puts "Coming here"
    end
    @browser.element(:tag_name=>"svg").element(:tag_name=>"path").click
    @browser.div(:class=>"DetailLink").when_present.flash.click
    sleep 10
    actual=self.pageTitle_element.flash.text
    puts "actual : #{actual}"
    return actual
  end

  def chk_copyrights
    self.logout
    sleep 10
    copyrights=@browser.div(:class=>"xwtLoginCopyright").text
    if copyrights.include? "2015"
      return true
    else
      return false
    end
  end

  def ifUtilCalview_chkicon
    @browser.scroll.to :center
    interface_name="GigabitEthernet"
    interfaceParent.div(:class=>"table-head-node-container").div(:class=>"xwtFilterByExample").div(:class=>"cell-0").text_field(:class=>"dijitInputInner").when_present.set(interface_name)
    sleep 8
    if $browser_type == :ie10
      interfaceParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.double_click
    else
      interfaceParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.click
    end
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"CalenderLink").when_present.flash.click
    sleep 10
    if self.chart_Icon_element.present? && self.table_Icon_element.present? && self.chartactIcon_element.present? && self.chartmoreIcon_element.present?
      return true
    else
      return false
    end
  end

  def ifUtilCalview_chkmoreact_popup
    @browser.div(:class=>"bottomIcons").div(:class=>"chartMoreActionIcon").flash.click
    if @browser.div(:class=>"xwtMoreActionPopup").div(:class=>"actionDropDownItem",:title=>"schedule Report").present? &&
    @browser.div(:class=>"xwtMoreActionPopup").div(:class=>"actionDropDownItem",:title=>"Export").present? &&
    @browser.div(:class=>"xwtMoreActionPopup").div(:class=>"actionDropDownItem",:title=>"Print").present?
      return true
    else
      return false
    end
  end

  def ifUtilCalview_schdrpt
    @browser.div(:class=>"xwtMoreActionPopup").div(:class=>"actionDropDownItem",:title=>"schedule Report").flash.click
    sleep 2
    self.schedule_report
  end

  def ifUtilCalview_filtertype
    actual=[]
    arr=[0,1,3,4]
    for i in (arr)
      actual << @browser.div(:class=>"filterDiv").table.tr(:index=>i).td.text
    end
    puts "Actual: #{actual}"
    return actual
  end

  def ifUtilCalview_sitesearchbox
    if self.radio_siteselect_element.checked?
      puts "Site radio Already checked"
    else
      self.radio_siteselect_element.click
    end
    @browser.div(:class=>"filterDiv").table.tr(:index=>1).div(:class=>"dijitDownArrowButton").click
    sleep 2
    if @browser.div(:class=>"xwtFilterbarCenter",:index=>0).div(:class=>"xwtFilterSearchBox").present?
      @browser.div(:class=>"filterDiv").table.tr(:index=>1).div(:class=>"dijitDownArrowButton").click
      return true
    else
      @browser.div(:class=>"filterDiv").table.tr(:index=>1).div(:class=>"dijitDownArrowButton").click
      return false
    end
  end

  def ifUtilCalview_ifgrpsearchbox
    if self.radio_ifselect_element.checked?
      puts "Ifgrp radio Already checked"
    else
      self.radio_ifselect_element.click
    end
    @browser.div(:class=>"filterDiv").table.tr(:index=>2).div(:class=>"dijitDownArrowButton").click
    sleep 2
    if @browser.div(:class=>"xwtFilterbarCenter",:index=>1).div(:class=>"xwtFilterSearchBox").present?
      @browser.div(:class=>"filterDiv").table.tr(:index=>2).div(:class=>"dijitDownArrowButton").click
      return true
    else
      @browser.div(:class=>"filterDiv").table.tr(:index=>2).div(:class=>"dijitDownArrowButton").click
      return false
    end
  end

  def ipv6_ifutil(ipv6DeviceName)
    @browser.scroll.to :center
    puts "DeviceName: #{ipv6DeviceName}"
    device_name=ipv6DeviceName
    interfaceParent.div(:class=>"table-head-node-container").div(:class=>"xwtFilterByExample").div(:class=>"cell-1").text_field(:class=>"dijitInputInner").when_present.set(device_name)
    actual = interfaceParent.div(:class=>"table-container").div(:class=>"row-0").div(:class=>"cell-1").text
    puts "Actual Device Name: #{actual}"
    return actual
  end

  def ipv6_ifutilQV
    if $browser_type == :ie10
      interfaceParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.double_click
    else
      interfaceParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.click
    end
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    actual = @browser.div(:id,"#{popid}").span(:class=>"xwtPopoverTitle").title
    puts "Actual Device Name: #{actual}"
    return actual
  end

  def ipv6_ifutilDV
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"DetailLink").when_present.flash.click
    sleep 10
    actual = @browser.div(:class=>"xwtTitleNodeContainer",:index=>1).div(:class=>"xwtTitlePaneTextNode").text
    puts "Actual Device Name: #{actual}"
    return actual
  end

  def ipv6_ifutilCV(ipv6DeviceName)
    navigate_application_to "Home"
    sleep 5
    @browser.scroll.to :center
    device_name=ipv6DeviceName
    interfaceParent.div(:class=>"table-head-node-container").div(:class=>"xwtFilterByExample").div(:class=>"cell-1").text_field(:class=>"dijitInputInner").when_present.set(device_name)
    if $browser_type == :ie10
      interfaceParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.double_click
    else
      interfaceParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.click
    end
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"CalenderLink").when_present.flash.click
    sleep 10
    actual = @browser.div(:id=>"interfaceTitle").text
    puts "Actual Device Name: #{actual}"
    return actual
  end

  def ipv6_errd(ipv6DeviceName)
    navigate_application_to "Home"
    new_tab="Errors and Discards"
    self.select_dashboard_tab(new_tab)
    puts "DeviceName: #{ipv6DeviceName}"
    device_name=ipv6DeviceName
    errorParent.div(:class=>"table-head-node-container").div(:class=>"xwtFilterByExample").div(:class=>"cell-1").text_field(:class=>"dijitInputInner").when_present.set(device_name)
    actual = errorParent.div(:class=>"table-container").div(:class=>"row-0").div(:class=>"cell-1").text
    puts "Actual Device Name: #{actual}"
    return actual
  end

  def ipv6_errd_DV
    if $browser_type == :ie10
      interfaceParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.double_click
    else
      interfaceParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.click
    end
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"DetailLink").when_present.flash.click
    sleep 10
    actual = @browser.div(:class=>"xwtTitleNodeContainer",:index=>1).div(:class=>"xwtTitlePaneTextNode").text
    puts "Actual Device Name: #{actual}"
    return actual
  end

  def ipv6_QoS(ipv6DeviceName)
    navigate_application_to "Home"
    new_tab="QoS Classes"
    self.select_dashboard_tab(new_tab)
    puts "DeviceName: #{ipv6DeviceName}"
    device_name=ipv6DeviceName
    qosParent.div(:class=>"table-head-node-container").div(:class=>"xwtFilterByExample").div(:class=>"cell-1").text_field(:class=>"dijitInputInner").when_present.set(device_name)
    actual = errorParent.div(:class=>"table-container").div(:class=>"row-0").div(:class=>"cell-1").text
    puts "Actual Device Name: #{actual}"
    return actual
  end

  def ipv6_QoS_QV
    if $browser_type == :ie10
      interfaceParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.double_click
    else
      interfaceParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon").when_present.flash.click
    end
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    actual = @browser.div(:id,"#{popid}").span(:class=>"xwtPopoverTitle").title
    puts "Actual Device Name: #{actual}"
    @browser.div(:id,"#{popid}").div(:class=>"xwtPopoverClose").flash.click
    return actual
  end

  def ipv6_QoS_DV
    if $browser_type == :ie10
      interfaceParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon",:index=>1).when_present.flash.double_click
    else
      interfaceParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon",:index=>1).when_present.flash.click
    end
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"DetailLink").when_present.flash.click
    sleep 10
    actual = @browser.div(:class=>"xwtTitleNodeContainer",:index=>1).div(:class=>"xwtTitlePaneTextNode").text
    puts "Actual Device Name: #{actual}"
    return actual
  end

def ipv6_fulllength(ipv6DeviceName)
    navigate_application_to "Home"
    @browser.scroll.to :center
    puts "DeviceName: #{ipv6DeviceName}"
    device_name=ipv6DeviceName
    interfaceParent.div(:class=>"table-head-node-container").div(:class=>"xwtFilterByExample").div(:class=>"cell-1").text_field(:class=>"dijitInputInner").when_present.set(device_name)
    actual = interfaceParent.div(:class=>"table-container").div(:class=>"row-0").div(:class=>"cell-1").text
    puts "Actual Device Name: #{actual}"
    return actual
  end
  
  def ipv6_saiku
    navigate_application_to "Report=>Custom Views"
    @browser.span(:id=>"launchSaiku").flash.click
    sleep 2
    @browser.div(:id => "iframe").iframe.div(:id, "tab_panel").select_list(:class, "cubes").option(:value => "pcwh/Prime Infrastructure/Prime Infrastructure/CVInterfaceUtilizationLastAll").select
    @browser.div(:id => "iframe").iframe.div(:id, "tab_panel").div(:class => "measure_tree").li(:class => "ui-draggable").a(:class => "measure", :title => "[Measures].[MaxInputUtilization]").wd.location_once_scrolled_into_view
    sleep 2
    ind =0
    @browser.div(:id => "iframe").iframe.div(:id, "tab_panel").div(:class => "measure_tree").lis(:class => "ui-draggable").each do |s|
      measure = s.a(:class => "measure").text
      if measure == "MaxInputUtilization"
        @browser.div(:id => "iframe").iframe.div(:id, "tab_panel").div(:class => "measure_tree").li(:class => "ui-draggable").a(:class => "measure", :text => "MaxInputUtilization").flash.click
      end
      if measure == "MaxOutputUtilization"
        @browser.div(:id => "iframe").iframe.div(:id, "tab_panel").div(:class => "measure_tree").li(:class => "ui-draggable", :index => ind).a(:class => "measure", :text => "MaxOutputUtilization").flash.click
      end
      ind = ind + 1
    end
    sleep 2
    @browser.div(:id => "iframe").iframe.div(:id, "tab_panel").div(:class => "workspace_toolbar").a(:class => "i18n swap_axis button sprite i18n_failed i18n_translated", :title => "Swap axis").flash.click
    sleep 2
    @browser.div(:id=>"iframe").iframe.div(:id, "tab_panel").li(:class=>"parent_dimension",:index=>2).a(:class=>"folder_collapsed sprite").flash.click
    @browser.div(:id=>"iframe").iframe.div(:id,"tab_panel").li(:class=>"parent_dimension",:index=>2).a(:class => "level",:title=>"Device IP").flash.click
    sleep 3
    @browser.div(:id=>"iframe").iframe.div(:id, "tab_panel").div(:class => "workspace_toolbar").a(:class => "i18n run button sprite i18n_failed i18n_translated", :title => "Run query").flash.click
    actual = []
    @browser.div(:id, "iframe").iframe.div(:id, "tab_panel").div(:class => "workspace_results ui-droppable").ths(:class=>"col headerhighlight").each do |s|
      value= s.text
      actual << value
    end
    return actual
  end
end