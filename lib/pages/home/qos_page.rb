class QOS < ErrorsandDiscardsPage

  # Page objects for QOS Classes interface quickView

  div(:interfacePopupID,:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight")
  div(:interfaceClassPopupID){interfacePopupID_element.div_element(:id=>interfacePopupID_element.id)}
  div(:closePopUP){interfacePopupID_element.div_element(:id=>interfacePopupID_element.id).div(:title=>"Close")}
  div(:popUPTitle){interfacePopupID_element.div_element(:id=>interfacePopupID_element.id).span(:class,"xwtPopoverTitle")}
  div(:dateTime){interfacePopupID_element.div_element(:id=>interfacePopupID_element.id).div(:class=>"bottomIcons")}

  div(:chartButoon){interfacePopupID_element.div_element(:id=>interfacePopupID_element.id).div(:class=>"bottomIcons").div(:title=>"Chart Mode")}
  div(:gridButoon){interfacePopupID_element.div_element(:id=>interfacePopupID_element.id).div(:class=>"bottomIcons").div(:title=>"Grid Mode")}
  div(:chart){interfacePopupID_element.div_element(:id=>interfacePopupID_element.id).div(:class=>"chartNode")}
  div(:grid){interfacePopupID_element.div_element(:id=>interfacePopupID_element.id).div(:class=>"gridNode")}

  div(:interfaceGridColumn1){interfacePopupID_element.div_element(:id=>interfacePopupID_element.id).div(:class=>"gridNode").div(:class,"dojoxGridHeader").th(:id,"xwt_widget_datagrid_EnhancedGrid_0Hdr0")}
  div(:interfaceGridColumn2){interfacePopupID_element.div_element(:id=>interfacePopupID_element.id).div(:class=>"gridNode").div(:class,"dojoxGridHeader").th(:id,"xwt_widget_datagrid_EnhancedGrid_0Hdr1")}
  div(:interfaceGridColumn3){interfacePopupID_element.div_element(:id=>interfacePopupID_element.id).div(:class=>"gridNode").div(:class,"dojoxGridHeader").th(:id,"xwt_widget_datagrid_EnhancedGrid_0Hdr2")}

  div(:chartTooltip){interfacePopupID_element.div_element(:id=>interfacePopupID_element.id).div(:class=>"chartNode").element(:css => "svg").elements(:css => "polyline")}
  div(:chartTooltipParticular){interfacePopupID_element.div_element(:id=>interfacePopupID_element.id).div(:class=>"chartNode").element(:css => "svg").element(:css => "polyline")}

  div(:interfaceXaxisPercentage){interfacePopupID_element.div_element(:id=>interfacePopupID_element.id).div(:class=>"chartNode").element(:text=>"Percentage")}
  div(:interfaceYaxisTimePeriod){interfacePopupID_element.div_element(:id=>interfacePopupID_element.id).div(:class=>"chartNode").element(:text=>"Time Period")}

  div(:classNameXaxisPercentage){interfacePopupID_element.div_element(:id=>interfacePopupID_element.id).div(:class=>"chartNode").element(:text=>"(bps)")}
  div(:classNameYaxisTimePeriod){interfacePopupID_element.div_element(:id=>interfacePopupID_element.id).div(:class=>"chartNode").element(:text=>"Time Period")}

  div(:exportPrintButoon){interfacePopupID_element.div_element(:id=>interfacePopupID_element.id).div(:class=>"bottomIcons").div(:title=>"Export/Print")}
  div(:smallPopupID,:class=>"dijitPopup Popup")
  div(:scheduleReport){smallPopupID_element.div_element(:id=>smallPopupID_element.id).div(:class=>"dijitInline itemLabel",:text=>"Schedule Report")}

  #Page object for QOS Detail View

  div(:qosInterfaceTitle1,:class=>"xwtTitlePaneTitle dijitOpen",:index=>1)
  div(:qosInterfaceTitle2,:class=>"xwtTitlePaneTitle dijitOpen",:index=>2)
  div(:qosInterfaceTitle3,:class=>"xwtTitlePaneTitle dijitOpen",:index=>3)

  div(:chartHeader,:class=>"xwtTitlePaneContentOuter",:index=>1)
  div(:firstInterfaceChart){chartHeader_element.div(:class=>"chartNode")}
  div(:firstInterfacegrid){chartHeader_element.div(:class=>"gridNode")}
  div(:firstChartBottom){chartHeader_element.div(:class=>"bottomRegion")}
  div(:firstChartGridMode){chartHeader_element.div(:class=>"bottomRegion").div(:title=>"Grid Mode")}
  div(:firstChartMode){chartHeader_element.div(:class=>"bottomRegion").div(:title=>"Chart Mode")}
  div(:firstCharTypes){chartHeader_element.div(:class=>"bottomRegion").div(:title=>"Chart Types")}
  div(:firstChartGridModeHeader){chartHeader_element.div(:class=>"gridNode").div(:class=>"dojoxGridHeader")}
  div(:firstChartGridTableData){chartHeader_element.div(:class=>"dojoxGridContent")}

  div(:chartHeaderSecond,:class=>"xwtTitlePaneContentOuter",:index=>2)
  div(:secondInterfaceChart){chartHeaderSecond_element.div(:class=>"chartNode")}
  div(:postCheckBox){chartHeaderSecond_element.div(:class=>"chartNode").input(:index=>0)}

  div(:chartHeaderThird,:class=>"xwtTitlePaneContentOuter",:index=>3)
  div(:thirdInterfaceChart){chartHeaderThird_element.div(:class=>"chartNode")}

  def goto
    navigate_application_to "Home"
  end

  def loaded?(*how)
    global_toolbar_element.exists?
  end

  def qosParent
    ind = 0
    while ! @browser.div(:id,"xwt_widget_layout_TabContentPane_#{ind}").present?
      puts ind
      ind = ind + 1
    end
    @browser.div(:id,"xwt_widget_layout_TabContentPane_#{ind}")
  end

  def qos_Filter
    output=[]
    a=qosParent.div(:class=>"dijitInline filters").divs(:class=>"dijitInline dbFilter")
    a.each do |p|
      p.div(:class=>"dijitInline dbFilterLabel").flash
      output<<p.div(:class=>"dijitInline dbFilterLabel").text
    end
    return output
  end

  def qosClassmap_Filter
    qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:class,/dijitReset dijitRight dijitButtonNode dijitArrowButt/).flash.click
    if $browser_type == :ie10
      qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:class,/dijitReset dijitRight dijitButtonNode dijitArrowButt/).flash.click
    else
      puts"The Running browser is not an IE"
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

  def qosTable_ColumnName
    sleep 3
    actualfirst=[]
    qosParent.div(:class=>"table-header-container filter-by-example").td(:class=>"cell-container").flash
    all=qosParent.div(:class=>"table-header-container filter-by-example").tds(:class=>"cell-container")
    all.each do |p|
      p.div(:class=>"cell").focus
      actualfirst << p.div(:class=>"cell").text
    end
    actuallast=actualfirst.uniq
    b=actuallast.reject(&:empty?)
    return b
  end

  def qostable_sorting
    sleep 3
    uiall = []
    uiall = qosParent.div(:class=>"table dijitLayoutContainer dijitContainer emsamHiddenBottomLine").div(:class,"table-container").divs(:class,/row noSe/)
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
    qosParent.div(:class=>"table dijitLayoutContainer dijitContainer emsamHiddenBottomLine").div(:class,"table-head-node-container").table(:class,"table-header").td(:class => /cell-container-7/).when_present.flash.click
    #     sleep 5
    uiall = qosParent.div(:class=>"table dijitLayoutContainer dijitContainer emsamHiddenBottomLine").div(:class,"table-container").divs(:class,/row noSe/)
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
    qosParent.table(:class,"table-header").td(:class => /cell-container-7/).when_present.flash.click
    uiall = qosParent.div(:class=>"table dijitLayoutContainer dijitContainer emsamHiddenBottomLine").div(:class,"table-container").divs(:class,/row noSe/)
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

  def classmapFilter_AllOption

    qosParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      qosParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 10
    @browser.li(:text=>"Last 2 Weeks").when_present.flash.click # Check how to apply .yml data
    qosParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>0).when_present.flash.click
    sleep 2
    #    self.ok_a_element.fire_event "onclick"
    qosParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.flash.click
    sleep 2
    #    self.ok_b_element.fire_event "onclick"
    qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
    qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 3 
    @browser.li(:text=>"All").when_present.flash.click
    qosParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 3
    class_Name=qosParent.div(:class=>"table-header-container filter-by-example").table(:class=>"table-header",:index=>1).td(:class=>"cell-container-2").text_field(:class=>"dijitInputInner")
    location=qosParent.div(:class=>"table-header-container filter-by-example").table(:class=>"table-header",:index=>1).td(:class=>"cell-container-3").text_field(:class=>"dijitInputInner")
    class_Name.when_present.set"QPM_PQ"
    uiall = qosParent.div(:class=>"table dijitLayoutContainer dijitContainer emsamHiddenBottomLine").div(:class,"table-container").divs(:class,/row noSe/)
    qpm_pq = []
    uiall.each do |p|
      #      p.table(:class,"row-table").tr.td(:class => /cell-container/, :index =>2).flash
      qpm_pq << p.table(:class,"row-table").tr.td(:class =>"cell-container",:index =>2).text
    end
    puts"qpm_pq_before: #{qpm_pq}"
    qpm_final=qpm_pq.uniq
    puts"qpm_pq: #{qpm_final}"

    sleep 3
    class_Name.when_present.clear
    location.when_present.flash.click
    class_Name.when_present.set"class-default"
    uiallnew = qosParent.div(:class=>"table dijitLayoutContainer dijitContainer emsamHiddenBottomLine").div(:class,"table-container").divs(:class,/row noSe/)
    default=[]
    uiallnew.each do |new|
      #      new.table(:class,"row-table").tr.td(:class => /cell-container/, :index =>2).flash
      default << new.table(:class,"row-table").tr.td(:class =>"cell-container",:index =>2).text
    end
    puts"default_before: #{default}"
    default_final=default.uniq
    puts "default: #{default_final}"
    actual=qpm_final.concat(default_final)
    puts "actual class map :#{actual}"
    expect=["QPM_PQ","class-default"]
    if actual == expect
      puts "Success-All class map details is displayed in table"
      return true
    else
      puts "Failure-All class map details is not displayed in table"
      return false
    end
  end

  def classmapFilter_QPM_PQ_Option

    class_Name=qosParent.div(:class=>"table-header-container filter-by-example").table(:class=>"table-header",:index=>1).td(:class=>"cell-container-2").text_field(:class=>"dijitInputInner")
    location=qosParent.div(:class=>"table-header-container filter-by-example").table(:class=>"table-header",:index=>1).td(:class=>"cell-container-3").text_field(:class=>"dijitInputInner")
    class_Name.when_present.clear
    qosParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      qosParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 10
    @browser.li(:text=>"Last 2 Weeks").when_present.flash.click # Check how to apply .yml data
    qosParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>0).when_present.flash.click
    sleep 2
    #    self.ok_a_element.fire_event "onclick"
    qosParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.flash.click
    sleep 2
    #    self.ok_b_element.fire_event "onclick"
    qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
    qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
      qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 3
    @browser.li(:text=>"QPM_PQ").when_present.flash.click
    qosParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 3
    class_Name.when_present.set"QPM_PQ"
    uiall = qosParent.div(:class=>"table dijitLayoutContainer dijitContainer emsamHiddenBottomLine").div(:class,"table-container").divs(:class,/row noSe/)
    qpm_pq = []
    uiall.each do |p|
      #      p.table(:class,"row-table").tr.td(:class => /cell-container/, :index =>2).flash
      qpm_pq << p.table(:class,"row-table").tr.td(:class =>"cell-container",:index =>2).text
    end
    puts"qpm_pq_before: #{qpm_pq}"
    qpm_final=qpm_pq.uniq
    puts"qpm_pq: #{qpm_final}"
    expect=["QPM_PQ"]
    if qpm_final == expect
      puts "Success-QPM_PQ class map details is displayed in table"
      return true
    else
      puts "Failure-QPM_PQ class map details is not displayed in table"
      return false
    end
  end

  def classmapFilter_QPM_PQ_Option_DurarionAllOptions

    class_Name=qosParent.div(:class=>"table-header-container filter-by-example").table(:class=>"table-header",:index=>1).td(:class=>"cell-container-2").text_field(:class=>"dijitInputInner")
    location=qosParent.div(:class=>"table-header-container filter-by-example").table(:class=>"table-header",:index=>1).td(:class=>"cell-container-3").text_field(:class=>"dijitInputInner")
    for i in 0..8
      class_Name.when_present.clear
      location.when_present.flash.click
      sleep 5
      qosParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
      if $browser_type == :ie10
        qosParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
      else
        puts"Running Browser is not an IE"
      end
      #      @browser.li(:text=>"Last 2 Weeks").fire_event "onclick" # Check how to apply .yml data
      @browser.li(:index=>i).when_present.flash.click # Check how to apply .yml data
      qosParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>0).when_present.flash.click
      sleep 2
      #      self.ok_a_element.fire_event "onclick"
      qosParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.flash.click
      sleep 2
      #      self.ok_b_element.fire_event "onclick"
      qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
      qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
      if $browser_type == :ie10
        qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
        qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
      else
        puts"Running Browser is not an IE"
      end
      sleep 3
      @browser.li(:text=>"QPM_PQ").when_present.flash.click
      qosParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
      sleep 3
      class_Name.when_present.set"QPM_PQ"
      uiall = qosParent.div(:class=>"table dijitLayoutContainer dijitContainer emsamHiddenBottomLine").div(:class,"table-container").divs(:class,/row noSe/)
      qpm_pq = []
      uiall.each do |p|
        #        p.table(:class,"row-table").tr.td(:class => /cell-container/, :index =>2).flash
        qpm_pq << p.table(:class,"row-table").tr.td(:class =>"cell-container",:index =>2).text
      end
      puts"qpm_pq_before: #{qpm_pq}"

    end

    qpm_final=qpm_pq.uniq
    puts"qpm_pq: #{qpm_final}"
    expect=["QPM_PQ"]
    if qpm_final == expect
      puts "Success-QPM_PQ class map and Last 2 Weeks Duration details is displayed in table"
      return true
    else
      puts "Failure-QPM_PQ class map and Last 2 Weeks Duration details is not displayed in table"
      return false
    end
  end

  def classmapFilter_ClassDefault_Option

    class_Name=qosParent.div(:class=>"table-header-container filter-by-example").table(:class=>"table-header",:index=>1).td(:class=>"cell-container-2").text_field(:class=>"dijitInputInner")
    location=qosParent.div(:class=>"table-header-container filter-by-example").table(:class=>"table-header",:index=>1).td(:class=>"cell-container-3").text_field(:class=>"dijitInputInner")
    class_Name.when_present.clear
    location.when_present.clear

    qosParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      qosParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 10
    @browser.li(:text=>"Last 2 Weeks").when_present.flash.click # Check how to apply .yml data
    qosParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>0).when_present.flash.click
    sleep 2
    #    self.ok_a_element.fire_event "onclick"
    qosParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.flash.click
    sleep 2
    #    self.ok_b_element.fire_event "onclick"
    qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
    qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
      qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 3
    @browser.li(:text=>"class-default").when_present.flash.click
    qosParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 3
    class_Name.when_present.set"class-default"
    uiall = qosParent.div(:class=>"table dijitLayoutContainer dijitContainer emsamHiddenBottomLine").div(:class,"table-container").divs(:class,/row noSe/)
    classDefault = []
    uiall.each do |p|
      #      p.table(:class,"row-table").tr.td(:class => /cell-container/, :index =>2).flash
      classDefault << p.table(:class,"row-table").tr.td(:class =>"cell-container",:index =>2).text
    end
    puts"class_default before: #{classDefault}"
    classDefault_final=classDefault.uniq
    puts"qpm_pq: #{classDefault_final}"
    expect=["class-default"]
    if classDefault_final == expect
      puts "Success-class-default class map details is displayed in table"
      return true
    else
      puts "Failure-class-default class map details is not displayed in table"
      return false
    end
  end

  def classmapFilter_ClassDefault_DurationAllOptions

    class_Name=qosParent.div(:class=>"table-header-container filter-by-example").table(:class=>"table-header",:index=>1).td(:class=>"cell-container-2").text_field(:class=>"dijitInputInner")
    location=qosParent.div(:class=>"table-header-container filter-by-example").table(:class=>"table-header",:index=>1).td(:class=>"cell-container-3").text_field(:class=>"dijitInputInner")
    for i in 0..8
      location.when_present.clear
      class_Name.when_present.clear
      sleep 5
      qosParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
      if $browser_type == :ie10
        qosParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
      else
        puts"Running Browser is not an IE"
      end
      @browser.li(:index=>i).when_present.flash.click # Check how to apply .yml data
      qosParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>0).when_present.flash.click
      sleep 2
      #      self.ok_a_element.fire_event "onclick"
      qosParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.flash.click
      sleep 2
      #      self.ok_b_element.fire_event "onclick"
      qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
      qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
      if $browser_type == :ie10
        qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
        qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
      else
        puts"Running Browser is not an IE"
      end
      sleep 3
      @browser.li(:text=>"class-default").when_present.flash.click
      qosParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
      sleep 3
      class_Name.when_present.set"class-default"
      uiall = qosParent.div(:class=>"table dijitLayoutContainer dijitContainer emsamHiddenBottomLine").div(:class,"table-container").divs(:class,/row noSe/)
      classDefault = []
      uiall.each do |p|
        #        p.table(:class,"row-table").tr.td(:class => /cell-container/, :index =>2).flash
        classDefault << p.table(:class,"row-table").tr.td(:class =>"cell-container",:index =>2).text
      end
      puts"class_default before: #{classDefault}"
    end
    classDefault_final=classDefault.uniq
    puts"qpm_pq: #{classDefault_final}"
    expect=["class-default"]
    if classDefault_final == expect
      puts "Success-class-default class map details is displayed in table"
      return true
    else
      puts "Failure-class-default class map details is not displayed in table"
      return false
    end
  end

  def classmapFilterAllOption_DurationAllOptions

    class_Name=qosParent.div(:class=>"table-header-container filter-by-example").table(:class=>"table-header",:index=>1).td(:class=>"cell-container-2").text_field(:class=>"dijitInputInner")
    location=qosParent.div(:class=>"table-header-container filter-by-example").table(:class=>"table-header",:index=>1).td(:class=>"cell-container-3").text_field(:class=>"dijitInputInner")
    for i in 0..8
      location.when_present.clear
      class_Name.when_present.clear
      sleep 5
      qosParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
      if $browser_type == :ie10
        errorParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
      else
        puts"Running Browser is not an IE"
      end
      @browser.li(:index=>i).fire_event "onclick" # Check how to apply .yml data
      qosParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>0).when_present.flash.click
      sleep 2
      #      self.ok_a_element.fire_event "onclick"
      qosParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.flash.click
      sleep 2
      #      self.ok_b_element.fire_event "onclick"
      qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
      qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
      if $browser_type == :ie10
        qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
        qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
      else
        puts"Running Browser is not an IE"
      end
      sleep 3
      @browser.li(:text=>"All").when_present.flash.click
      qosParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
      sleep 3
      class_Name.when_present.set"QPM_PQ"
      uiall = qosParent.div(:class=>"table dijitLayoutContainer dijitContainer emsamHiddenBottomLine").div(:class,"table-container").divs(:class,/row noSe/)
      qpm_pq = []
      uiall.each do |p|
        #      p.table(:class,"row-table").tr.td(:class => /cell-container/, :index =>2).flash
        qpm_pq << p.table(:class,"row-table").tr.td(:class =>"cell-container",:index =>2).text
      end
      puts"qpm_pq_before: #{qpm_pq}"
      sleep 3

      class_Name.when_present.clear
      location.when_present.flash.click
      class_Name.when_present.set"class-default"
      uiallnew = qosParent.div(:class=>"table dijitLayoutContainer dijitContainer emsamHiddenBottomLine").div(:class,"table-container").divs(:class,/row noSe/)
      default=[]
      uiallnew.each do |new|
        #      new.table(:class,"row-table").tr.td(:class => /cell-container/, :index =>2).flash
        default << new.table(:class,"row-table").tr.td(:class =>"cell-container",:index =>2).text
      end
      puts"default_before: #{default}"
    end

    qpm_final=qpm_pq.uniq
    puts"qpm_pq: #{qpm_final}"

    default_final=default.uniq
    puts "default: #{default_final}"

    actual=qpm_final.concat(default_final)
    puts "actual class map :#{actual}"
    expect=["QPM_PQ","class-default"]
    if actual == expect
      puts "Success-All class map details is displayed in table"
      return true
    else
      puts "Failure-All class map details is not displayed in table"
      return false
    end
  end

  def qosClasses_QuickFilter

    class_Name=qosParent.div(:class=>"table-header-container filter-by-example").table(:class=>"table-header",:index=>1).td(:class=>"cell-container-2").text_field(:class=>"dijitInputInner")
    location=qosParent.div(:class=>"table-header-container filter-by-example").table(:class=>"table-header",:index=>1).td(:class=>"cell-container-3").text_field(:class=>"dijitInputInner")
    class_Name.when_present.clear
    location.when_present.clear

    qosParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      qosParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 10
    @browser.li(:text=>"Last 2 Weeks").when_present.flash.click
    qosParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>0).when_present.flash.click
    sleep 2
    #    self.ok_a_element.fire_event "onclick"
    qosParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.flash.click
    sleep 2
    #    self.ok_b_element.fire_event "onclick"
    qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
    qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
      qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 3
    @browser.li(:text=>"All").when_present.flash.click
    qosParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click

    qosParent.div(:class=>"xwtQuickFilter").div(:class=>"icon-triangle icon-rotate-90").when_present.flash.click
    @browser.div(:class=>"dijitPopup dijitMenuPopup").tr(:index=>0).when_present.flash.click
    class_Name.present?
    class_Name.when_present.set"QPM_PQ"
    actual=qosParent.div(:class=>"table-container").div(:class=>/row noSe/).table(:class,"row-table").tr.td(:class =>"cell-container",:index =>2).text
    return actual
  end

  def interfaceQuickview_Footericons
    #    sleep 3
    class_Name=qosParent.div(:class=>"table-header-container filter-by-example").table(:class=>"table-header",:index=>1).td(:class=>"cell-container-2").text_field(:class=>"dijitInputInner")
    location=qosParent.div(:class=>"table-header-container filter-by-example").table(:class=>"table-header",:index=>1).td(:class=>"cell-container-3").text_field(:class=>"dijitInputInner")
    class_Name.when_present.clear
    sleep 10
    qosParent.div(:class=>"table-container").div(:class=>"row-1").span(:class=>"xwtPopoverHintHoverIcon",:index=>0).when_present.flash.click
    sleep 3
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    actualicon=[]
    @browser.div(:id,"#{popid}").div(:class=>"bottomIcons").flash
    all=@browser.div(:id,"#{popid}").div(:class=>"bottomIcons").divs(:class=>/dijitInline icon/)
    all.each do |a|
      actualicon<<a.title
    end
    return actualicon
  end

  def interfaceName_DetailedView
    sleep 2
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"DetailLink").when_present(5).flash.click
    sleep 3
    @browser.span(:class=>"xwtBreadcrumbText").flash
    #    actual=@browser.span(:class=>"xwtBreadcrumbText xwtBreadcrumbLast").text
    actual=self.pageTitle_element.text
  end

  def detailViewtoQOSClassesTab
    @browser.div(:class=>"breadCrumbHomeIcon").when_present.flash.click
    sleep 3
    @browser.span(:text=>"QoS Classes").when_present.flash.click
    sleep 3
  end

  def classNameQuickview_Footericons
    #    sleep 3
    #self.detailViewtoQOSClassesTab
    qosParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon",:index=>1).present?
    qosParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon",:index=>1).when_present(5).flash.click
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id

    actualicon=[]
    @browser.div(:id,"#{popid}").div(:class=>"bottomIcons").flash
    all=@browser.div(:id,"#{popid}").div(:class=>"bottomIcons").divs(:class=>/dijitInline icon/)
    all.each do |a|
      actualicon<<a.title
    end
    return actualicon
  end

  def classNameQuickview_ChartGridMode

    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"bottomIcons").div(:title=>"Chart Mode").present?
    @browser.div(:id,"#{popid}").div(:class=>"bottomIcons").div(:title=>"Grid Mode").when_present.flash.click
    actual=[]
    @browser.div(:id,"#{popid}").div(:class,"gridNode").div(:class,"dojoxGridHeader").th(:class=>"dojoxGridCell",:index=>1).flash
    actual<<@browser.div(:id,"#{popid}").div(:class,"gridNode").div(:class,"dojoxGridHeader").th(:class=>"dojoxGridCell",:index=>1).text
    @browser.div(:id,"#{popid}").div(:class,"gridNode").div(:class,"dojoxGridHeader").th(:class=>"dojoxGridCell",:index=>2).flash
    actual<<@browser.div(:id,"#{popid}").div(:class,"gridNode").div(:class,"dojoxGridHeader").th(:class=>"dojoxGridCell",:index=>2).text
    @browser.div(:id,"#{popid}").div(:class,"gridNode").div(:class,"dojoxGridHeader").th(:class=>"dojoxGridCell",:index=>3).flash
    actual<<@browser.div(:id,"#{popid}").div(:class,"gridNode").div(:class,"dojoxGridHeader").th(:class=>"dojoxGridCell",:index=>3).text
    return actual

  end

  def classNameQuickview_ChartTypeExportPrint

    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"bottomIcons").div(:title=>"Chart Types").present?
    @browser.div(:id,"#{popid}").div(:class=>"bottomIcons").div(:title=>"Chart Types").when_present.flash.click
    @browser.div(:class=>"dijitPopup Popup").present?
    @browser.div(:id,"#{popid}").div(:class=>"bottomIcons").div(:title=>"Export/Print").when_present(3).flash.click

    ind = 0
    until @browser.div(:id,"popup_#{ind}").present?
      puts ind
      ind = ind + 1
    end
    actual=[]
    all=@browser.div(:id,"popup_#{ind}").divs(:class,"actionDropDownItem groupChild nonSelectable")
    all.each do |p|
      actual << p.div(:class,"dijitInline itemLabel").text
    end
    return actual
  end

  def qosClasses_DetailedView
    qosParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon",:index=>1).when_present(5).flash.click
    sleep 2
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"DetailLink").when_present(5).flash.click
    sleep 3
    @browser.span(:class=>"xwtBreadcrumbText").flash
    #    actual=@browser.span(:class=>"xwtBreadcrumbText xwtBreadcrumbLast").text
    actual=self.pageTitle_element.text
  end

  def qosClasses_setting
    qosParent.div(:class=>"xwtGlobalToolbarActions").span(:class=>"dijitReset dijitStretch dijitButtonContents dijitDownArrowButton").when_present.flash.click
    self.column_element.when_present.flash.click
    @browser.div(:class=>"columnsContainerDiv").td(:text=>"Interface Name").when_present.flash.click
    @browser.div(:class=>"columnsContainerDiv").td(:text=>"Device Name").when_present.flash.click
    self.reset_element.when_present.flash.click
    self.close_element.when_present.flash.click

    if qosParent.div(:class=>"table-head-node-container").div(:text=>"Interface Name").present?
      puts "Success-The new column is added on interface utilization table"
      return true
    else if qosParent.div(:class=>"table-head-node-container").div(:text=>"Device Name").present?
        puts "Success-The new column is added on interface utilization table"
        return true
      else
        puts "Failure-The new column is not added on interface utilization table"
        return false
      end
    end
  end

  def qosClasses_InterfaceChartNode

    qosParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      qosParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 10
    @browser.li(:text=>"Last 2 Weeks").when_present.flash.click
    qosParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>0).when_present.flash.click
    sleep 2
    #    self.ok_a_element.fire_event "onclick"
    qosParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.flash.click
    sleep 2
    #    self.ok_b_element.fire_event "onclick"
    qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
    qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
      qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 3
    @browser.li(:text=>"All").when_present.flash.click
    qosParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click
    sleep 10
    qosParent.div(:class=>"table-container").div(:class=>"row-1").span(:class=>"xwtPopoverHintHoverIcon",:index=>0).when_present.flash.click
  end

  def qosClasses_ClassNameQuickView

    qosParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      qosParent.div(:class =>"dashboardFilter").div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 10
    #    @browser.li(:text=>"Last 2 Weeks").fire_event "onclick"
    @browser.li(:text=>"Last 2 Weeks").when_present.flash.click
    qosParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>0).when_present.flash.click
    sleep 2
    #    self.ok_a_element.fire_event "onclick"
    #    self.ok_a_element.flash.click
    qosParent.div(:class=>"dashboardFilter").div(:title=>"Toggle Picker",:index=>1).when_present.flash.click
    sleep 2
    #    self.ok_b_element.fire_event "onclick"
    #    self.ok_a_element.flash.click
    qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
    qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
    if $browser_type == :ie10
      qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
      qosParent.div(:class =>"dijitInline dbFilter",:index=>3).div(:index=>2).div(:class=>"dijitDownArrowButton").when_present.flash.click
    else
      puts"Running Browser is not an IE"
    end
    sleep 3
    @browser.li(:text=>"All").when_present.flash.click
    qosParent.div(:class=>"dashboardFilter").span(:text,"Apply").when_present.flash.click

    #    qosParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon",:index=>1).when_present(5).flash.click

    #    sleep 3
    #    qosParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon",:index=>1).when_present(5).flash.click
    #    sleep 2
    #    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    #    @browser.div(:id,"#{popid}").div(:class=>"DetailLink").when_present(2).flash
    #    @browser.div(:id,"#{popid}").div(:class=>"DetailLink").when_present(5).flash.click

  end

  def interfcaeQuickViewChart_XandY_AxisLabel
    sleep 5
    xaxisActual=self.interfaceXaxisPercentage_element.text
    yaxisActual=self.interfaceYaxisTimePeriod_element.text

    if xaxisActual == "Percentage" && yaxisActual == "Time Period"
      puts "Success-The X-Axis and Y-Axis should have the expect title"
      return true
    else
      puts "Failure-The X and Y axis should not have the expect title"
      return false
    end
  end

  def qosClassesChart_allTooltip
    sleep 5
    chartelement = []
    all=self.chartTooltip_element
    all.each do |p|
      p.when_present(15).flash.click
      #      p.fire_event("onmouseover")
      p.hover
      chartelement << self.tooltipValue_element.text
      sleep 3
    end
    chartelement_uniq = chartelement.uniq
  end

  def qosClassesChart_PerticularTooltip
    sleep 5
    chartelement = []
    all=self.chartTooltipParticular_element
    all.when_present(15).flash.click
    #    all.fire_event("onmouseover")
    p.hover
    chartelement << self.tooltipValue_element.text
    sleep 3
    chartelement_uniq = chartelement.uniq
  end

  def qosClasses_interfaceQuickViewTitle
    self.closePopUP_element.when_present.flash.click
    sleep 3
    interfaceName=qosParent.div(:class=>"table-container").div(:class=>"row-1").table(:class,"row-table").tr.td(:class =>"cell-container",:index =>0).text
    deviceName=qosParent.div(:class=>"table-container").div(:class=>"row-1").table(:class,"row-table").tr.td(:class =>"cell-container",:index =>1).text
    expect=interfaceName<<"@"+deviceName+" Utilization"
    puts "expect title: #{expect}"
    sleep 10
    qosParent.div(:class=>"table-container").div(:class=>"row-1").span(:class=>"xwtPopoverHintHoverIcon",:index=>0).when_present.flash.click
    sleep 3
    self.popUPTitle_element.flash
    actual=self.popUPTitle_element.text
    puts "actual title: #{actual}"
    if actual == expect
      puts "Success-Quick popup should displayed proper title"
      return true
    else
      puts "Failure-Quick popup should not displayed proper title"
      return false
    end
  end

  def qosClassesquickview_InterfaceDate
    sleep 3
    chartTimestamp=self.dateTime_element.text
    actual=chartTimestamp[0..11]
    #    puts "actual date and time: #{actual}"
    return actual
  end

  def qosClassesquickview_InterfaceGridNodeColumnName

    self.gridButoon_element.when_present(5).flash.click
    actual=[]
    actual<<self.interfaceGridColumn1_element.text
    actual<<self.interfaceGridColumn2_element.text
    actual<<self.interfaceGridColumn3_element.text
    puts "actual column Name: #{actual}"
    return actual
  end

  def qosClasses_ClassNameChartNode

    self.closePopUP_element.when_present.flash.click
    qosParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon",:index=>1).when_present(5).flash.click
  end

  def qosClasses_ClassQuickViewTitle
    self.closePopUP_element.when_present.flash.click
    sleep 3
    tableClassName=qosParent.div(:class=>"table-container").div(:class=>/row noSe/).table(:class,"row-table").tr.td(:class =>"cell-container",:index =>2).text
    expect=tableClassName
    puts "expect title: #{expect}"
    qosParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon",:index=>1).when_present(5).flash.click
    sleep 3
    self.popUPTitle_element.present?
    self.popUPTitle_element.flash
    actual=self.popUPTitle_element.text
    puts "actual title: #{actual}"
    if actual == expect
      puts "Success-Quick popup should displayed proper title"
      return true
    else
      puts "Failure-Quick popup should not displayed proper title"
      return false
    end
  end

  def classNameQuickViewChart_XandY_AxisLabel
    sleep 5
    xaxisActual=self.classNameXaxisPercentage_element.text
    yaxisActual=self.classNameYaxisTimePeriod_element.text

    if xaxisActual == "(bps)" && yaxisActual == "Time Period"
      puts "Success-The X-Axis and Y-Axis should have the expect title"
      return true
    else
      puts "Failure-The X and Y axis should not have the expect title"
      return false
    end
  end

  def classNameQuichView_ExportCSVFormet
    #  sleep 5
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"bottomIcons").div(:title=>"Export/Print").when_present(3).flash.click
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
    puts "Last file path is: ",last_csv_file.path
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

  def classNameDetailView_InterfaceTitle
    self.detailViewtoQOSClassesTab
    sleep 3
    interfaceName=qosParent.div(:class=>"table-container").div(:class=>/row noSe/).table(:class,"row-table").tr.td(:class =>"cell-container",:index =>0).text
    deviceName=qosParent.div(:class=>"table-container").div(:class=>/row noSe/).table(:class,"row-table").tr.td(:class =>"cell-container",:index =>1).text
    expect=interfaceName<<"@"+deviceName+" - Input - AvgPrePolicyOctetsRate (Bps)"
    puts "Expect Ttile Name: #{expect}"
    qosParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon",:index=>1).when_present(5).flash.click
    sleep 2
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"DetailLink").when_present(5).flash.click
    sleep 10
    self.qosInterfaceTitle1_element.flash
    actual=self.qosInterfaceTitle1_element.text
    puts "Actual Ttile Name: #{actual}"
    if expect == actual
      puts "Success-The QOS Interface Title is matched"
      return true
    else
      puts "Failure-The QOS Interface Title is mismatched"
      return false
    end
  end

  def qosDetailview_Date
    self.detailViewtoQOSClassesTab
    sleep 5
    self.qosClasses_ClassNameQuickView
    qosParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon",:index=>1).when_present(5).flash.click
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
    sleep 5
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

  def qosDetailview_GraphLegendEnableDiable
    self.chartHeaderSecond_element.wd.location_once_scrolled_into_view
    sleep 2
    self.postCheckBox_element.flash.click
    sleep 2
    self.postCheckBox_element.flash.click
    inputBox= @browser.div(:class,"chartNode").element(:css => "svg").element(:css => "polyline")
    if inputBox.present?
      puts "Success-Graph should have Average Post Police"
      return true
    else
      raise "Failure-Graph should not have Average Post Police"
      return false
    end
  end

  def qosDetailview_GraphValue
    sleep 2
    chartelement = []
    all = @browser.div(:class,"chartNode").element(:css => "svg").elements(:css => "polyline")
    all.each do |p|
      p.when_present(15).flash.click
      #      p.fire_event("onmouseover")
      p.hover
      chartelement << self.tooltipValue_element.text
      sleep 3
    end
    chartelement_uniq = chartelement.uniq
    puts "Chart uniq value: #{chartelement_uniq}"
    return chartelement_uniq

  end

  def qosDetailsview_multipleSelection
    @browser.scroll.to :top
    @browser.div(:id=>"filterDiv").tr(:index=>2).div(:class=>"dijitDownArrowButton").flash.click
    sleep 1
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog xwt_BasePickerPopover dijitTooltipABLeft dijitTooltipBelow").id
    p popid
    avala = popid.scan(/[0-9#]+/i)
    a = avala[0]
    popvala = a.to_i
    p "before check box"
    sleep 5
    @browser.div(:id,"#{popid}").div(:class=>"xwtTreeNodeLabel").span(:index=>0).wd.location_once_scrolled_into_view
    #    @browser.div(:id,"#{popid}").div(:class=>"dijitTreeContainer").span(:class=>"dijitTreeLabel",:index=>2).parent.checkbox.fire_event('onclick')
    @browser.div(:id,"#{popid}").div(:class=>"dijitTreeContainer").span(:class=>"dijitTreeLabel",:index=>2).parent.checkbox.flash.click
    #    @browser.div(:id,"#{popid}").div(:class=>"dijitTreeContainer").span(:class=>"dijitTreeLabel",:index=>3).parent.checkbox.fire_event('onclick')
    p "after check box"
    @browser.div(:id,"#{popid}").div(:id,"xwt_widget_form_ObjectSelectorMultiPicker_#{popvala}_buttonContainer").span(:text,"OK").flash.click
    actualDevices=@browser.div(:id=>"filterDiv").tr(:index=>2).div(:class=>"xwt_BasePickerDisplayBox").text
    sleep 3
    if actualDevices == "Multiple selections"
      puts "Success-Multiple selection is displayed"
      return true
    else
      puts "Failure-Multiple selection is not displayed"
      return false
    end
  end

  def qosDetailview_PagingDetails

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
  end

  def qosDetailsview_timePeriod
    @browser.div(:id=>"filterDiv").tr(:index=>0).div(:class=>"dijitDownArrowButton").wd.location_once_scrolled_into_view
    @browser.div(:id=>"filterDiv").tr(:index=>0).div(:class=>"dijitDownArrowButton").when_present.flash.click
    actual=[]
    sleep 2
    all=@browser.div(:class=> "dijitReset dijitMenu dijitComboBoxMenu xwtComboBoxPopup").lis(:class=>"dijitReset dijitMenuItem")
    sleep 5
    all.each do |p|
      actual<<p.text
    end
    return actual
  end

  def qosDetailsview_FilterCollapseDecollapse
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

  def qosDetailsview_GridMode
    self.firstChartBottom_element.wd.location_once_scrolled_into_view
    self.firstChartGridMode_element.flash.click
    self.firstChartGridModeHeader_element.wd.location_once_scrolled_into_view
    self.firstChartGridModeHeader_element.present?
    tableValue=self.firstChartGridTableData_element.text
    puts "Chart data: #{tableValue}"
    return tableValue
  end

  def qosDetailViewGrid_sorting

    uiall = []
    uiall = @browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"gridNode").div(:class,"dojoxGridContent").divs(:class,"dojoxGridRow")
    unsorted = []
    uiall.each do |p|
      p.table(:class,"dojoxGridRowTable").tr.td(:class => "dojoxGridCell", :index => 2).flash
      unsorted << p.table(:class,"dojoxGridRowTable").tr.td(:class => "dojoxGridCell", :index => 2).text
    end
    ascendingsort  = unsorted.sort {|x, y| x <=> y}
    puts "Ascending", ascendingsort
    descendingsort = unsorted.sort! {|x, y| y <=> x}
    puts "Descending", descendingsort

    @browser.div(:class=>"gridNode").div(:class=>"dojoxGridMasterHeader").th(:class=>"dojoxGridCell dojoDndItem",:index=>2).when_present.flash.click
    uiall = @browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"gridNode").div(:class,"dojoxGridContent").divs(:class,"dojoxGridRow")
    sorted = []
    uiall.each do |p|
      p.table(:class,"dojoxGridRowTable").tr.td(:class => "dojoxGridCell", :index => 2).flash
      sorted << p.table(:class,"dojoxGridRowTable").tr.td(:class => "dojoxGridCell", :index => 2).text
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
    @browser.div(:class=>"gridNode").div(:class=>"dojoxGridMasterHeader").th(:class=>"dojoxGridCell dojoDndItem",:index=>2).when_present.flash.click
    uiall = @browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"gridNode").div(:class,"dojoxGridContent").divs(:class,"dojoxGridRow")
    sorted = []
    uiall.each do |p|
      p.table(:class,"dojoxGridRowTable").tr.td(:class => "dojoxGridCell", :index => 2).flash
      sorted << p.table(:class,"dojoxGridRowTable").tr.td(:class => "dojoxGridCell", :index => 2).text
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

  def qosDetailView_ExportCSVFormet
    #  sleep 5
    @browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"bottomIcons").div(:title=>"Export").when_present(3).flash.click
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
    puts "Last File path is: ",last_csv_file.path
    csv_file = File.read(last_csv_file)
    csv_data = CSV.parse(csv_file)
    csv_values = Array.new
    csv_data.each do  |row|
      puts row.inspect
      csv_values << row
    end
    return csv_values
  end

  def qosDetailView_ChartType
    @browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"bottomIcons").wd.location_once_scrolled_into_view
    @browser.div(:class=>"xwtTitlePaneContentOuter",:index=>1).div(:class=>"bottomIcons").div(:title=>"Chart Types").when_present(3).flash.click
    #    smallpop=@browser.div(:class=>"dijitPopup Popup").id
    ind=0
    until @browser.div(:id,"xwt_widget_charting_gridChart__ActionPopup_#{ind}").present?
      ind=ind+1
      puts "#{ind}"
    end
    chartType=@browser.div(:id,"xwt_widget_charting_gridChart__ActionPopup_#{ind}").div(:class=>"actionDropDownItem groupChild selected").text
    puts "Selected chart type is: #{chartType}"
    return chartType
  end

  def qosDetailView_SiteGroup
    @browser.scroll.to :top
    @browser.div(:id=>"filterDiv").tr(:index=>1).div(:class=>"dijitDownArrowButton").flash.click
    sleep 1
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog xwt_BasePickerPopover dijitTooltipABLeft dijitTooltipBelow").id
    p popid
    p "before check click"
    sleep 2
    if @browser.div(:id,"#{popid}").div(:class,"dijitTreeRow isTreeNodeContainer dijitTreeRowSelected").div(:class,"xwtTreeNodeLabel").span(:class,"dijitTreeExpando dijitTreeExpandoClosed").exists?
      @browser.div(:id,"#{popid}").div(:class,"dijitTreeRow isTreeNodeContainer dijitTreeRowSelected").div(:class,"xwtTreeNodeLabel").span(:class,"dijitTreeExpando dijitTreeExpandoClosed").flash.click
    else
      if @browser.div(:id,"#{popid}").div(:class,"dijitTreeRow isTreeNodeContainer dijitTreeRowHover").div(:class,"xwtTreeNodeLabel").span(:class,"dijitTreeExpando dijitTreeExpandoOpened").exists?
        @browser.div(:id,"#{popid}").div(:class,"dijitTreeRow isTreeNodeContainer dijitTreeRowHover").div(:class,"xwtTreeNodeLabel").span(:class,"dijitTreeExpando dijitTreeExpandoOpened").flash.click
      end
    end
    siteGroupList=@browser.div(:id,"#{popid}").div(:class=>"dijitTreeContainer").text
    puts "Site Group Detail Lists: #{siteGroupList}"
    return siteGroupList

  end

  def qosDetailView_InterfaceGroup
    @browser.scroll.to :top
    sleep 3
    @browser.div(:id=>"filterDiv").tr(:index=>3).div(:class=>"dijitDownArrowButton").flash.click
    sleep 1
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog xwt_BasePickerPopover dijitTooltipABLeft dijitTooltipBelow").id
    p popid
    @browser.div(:id,"#{popid}").div(:class=>"dijitTreeContainer").present?
    allInterface=@browser.div(:id,"#{popid}").div(:class=>"dijitTreeContainer").text
    puts "allInterface: #{allInterface}"

    #    @browser.div(:id,"#{popid}").div(:class=>"dijitTreeIsRoot dijitTreeNode dijitTreeNodeNotLoaded dijitNotLoaded").span(:class=>"dijitTreeLabel").present?
    #
    #    interfaceGroupList=[]
    #    all= @browser.div(:id,"#{popid}").divs(:class=>"dijitTreeIsRoot dijitTreeNode dijitTreeNodeNotLoaded dijitNotLoaded")
    #    all.each do |p|
    #      interfaceGroupList<<p.title
    #    end
    #
    #    puts "Site Group Detail Lists: #{interfaceGroupList}"
    return allInterface
  end

  def qosDetailView_ChartBottomIcons
    #    sleep 3
    qosParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon",:index=>1).present?
    qosParent.div(:class=>"table-container").span(:class=>"xwtPopoverHintHoverIcon",:index=>1).when_present(5).flash.click
    popid = @browser.div(:class=>"xwtPopover dijitTooltipDialog dijitTooltipABLeft dijitTooltipRight").id
    @browser.div(:id,"#{popid}").div(:class=>"DetailLink").when_present(5).flash.click
    sleep 5
    @browser.div(:class=>"bottomRegion",:index=>0).wd.location_once_scrolled_into_view
    @browser.div(:class=>"bottomRegion",:index=>0).flash
    actualicon=[]
    all=@browser.div(:class=>"bottomRegion",:index=>0).div(:class=>"bottomIcons").divs(:class=>"dijitInline")
    all.each do |a|
      actualicon<<a.title
    end
    return actualicon
  end

  def qosDetailView_ExportCSVFormet
    #  sleep 5
    @browser.div(:class=>"bottomIcons").div(:title=>"Export").when_present(3).flash.click
    ind = 0
    until @browser.div(:id,"popup_#{ind}").present?
      puts ind
      ind = ind + 1
    end
    @browser.div(:class=>"dijitInline itemLabel",:text=>"Export").when_present.flash.click

    ind=0
    until @browser.div(:id=>"xwt_widget_form_TextButtonGroup_#{ind}").present?
      puts ind
      ind = ind + 1
    end
    @browser.div(:id=>"xwt_widget_form_TextButtonGroup_#{ind}").span(:text=>"Export").when_present.flash.click
    sleep 15
    last_csv_file = on_page(GlobalPage).get_last_created($download_directory)
    puts "Last File Path is: ",last_csv_file.path
    csv_file = File.read(last_csv_file)
    csv_data = CSV.parse(csv_file)
    csv_values = Array.new
    csv_data.each do  |row|
      puts row.inspect
      csv_values << row
    end
    return csv_values
  end

end
