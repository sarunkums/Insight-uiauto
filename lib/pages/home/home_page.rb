class HomePage  < GenericDashboardPage

  div(:container, :id=>'com_cisco_xmp_web_page_Getting_Started')
  div(:interface_tab,:id=>"dojoUnique1")
  div(:errors_and_discards_tab, :id=>"dojoUnique2")
  div(:qos_classes_tab, :id=>"dojoUnique3")
  div(:table_data, :class=>"table-body")
  def goto
    puts "navigate"
    navigate_application_to "Home"
  end

  def loaded?(*how)
    dashboard_tab_element.exists? && dashboard_element.exists?
  end

  def custom_dashboard_settings
    sleep 3
    #@browser.span(:class=>"dijitReset dijitInline dijitButtonText",:text=>"Settings").when_present(15).focus
    #@browser.span(:class=>"dijitReset dijitInline dijitButtonText",:text=>"Settings").when_present(15).click
    @browser.span(:class=>"dijitReset dijitInline dijitButtonText",:text=>"Settings").when_present.click
    a=[]
    for i in 0..9
      b=@browser.div(:class=>"actionTitle",:index=>i).text
      a<<b
    end
    actual=a.reject(&:empty?)
    return actual
  end
  
  def dashlet_mode
    sleep 3
    dashid=@browser.div(:class =>"xwtDashlet",:index =>1).id
    puts "ID-#{dashid}"
    sleep 3
    @browser.div(:id,"#{dashid}").div(:class,"bottomRegion").div(:class => "dijitInline icon tableIcon",:title => "Grid Mode").focus
    @browser.div(:id,"#{dashid}").div(:class,"bottomRegion").div(:class => "dijitInline icon tableIcon",:title => "Grid Mode").click
    sleep 2
    if @browser.div(:id,"#{dashid}").div(:class,"gridNode").exists?
      sleep 2
      return true
      @browser.div(:id,"#{dashid}").div(:class,"bottomRegion").div(:title => "Chart Mode").click
    else if @browser.div(:id,"#{dashid}").div(:class,"chartNode").exists?
        return true
      else
        return false
      end
    end
  end

  def grid_mode

    dashid=@browser.div(:class =>"xwtDashlet",:index =>1).id
    @browser.div(:id,"#{dashid}").div(:class,"bottomRegion").div(:class => "dijitInline icon tableIcon",:title => "Grid Mode").click
    if @browser.div(:id,"#{dashid}").div(:class,"chartNode").present?
      return false
    else
      return true
    end
  end

  def dashlet_bottom_timestamp

    dashid=@browser.div(:class =>"xwtDashlet",:index =>1).id
    puts "ID-#{dashid}"
    sleep 3
    @browser.div(:id,"#{dashid}").div(:class,"bottomIcons").div(:title=>"Chart Types").when_present.flash.click
    sleep 3
    @browser.span(:class=>"dijitReset dijitInline dijitButtonText",:text=>"Settings").when_present(15).click
    @browser.span(:class=>"dijitReset dijitInline dijitButtonText",:text=>"Settings").when_present.flash.click
    @browser.div(:text=>"Add Dashlet(s)").when_present.flash.click
    @browser.div(:class=>"dashlet item selected").div(:class=>"searchBox").div(:class=>"clearSearchIcon").when_present.click
    if @browser.div(:id,"#{dashid}").div(:class,"bottomRegion").present?
      time=@browser.div(:id,"#{dashid}").div(:class,"bottomRegion").text
      puts "Time stamp:#{time}"
      return true
    else
      return false
    end

  end

  def chart_types

    dashid=@browser.div(:class =>"xwtDashlet",:index =>1).id
    puts "ID-#{dashid}"
    sleep 2
    @browser.div(:id,"#{dashid}").div(:class,"bottomIcons").div(:title=>"Chart Types").click
    sleep 2
    if @browser.div(:class=>"dijitPopup Popup").exists?

      puts "Success-All chart type is displayed"
      return true
    else
      puts "Failure-All chart type is not displayed"
      return false
    end

  end

  def homechart_tooltip_value

    dashid=@browser.div(:class =>"xwtDashlet",:index =>1).id
    @browser.div(:id,"#{dashid}").div(:class,"bottomRegion").div(:title => "Chart Mode").click
    puts "ID-#{dashid}"
    sleep 2
    chartelement = []
    #  all = @browser.div(:id,"#{dashid}").div(:class,"chartNode").element(:css => "svg").element(:css => "g").elements(:css => "rect")
    all = @browser.div(:id,"#{dashid}").div(:class,"chartNode").element(:css => "svg").element(:css => "g").elements
    sleep 5
    all.each do |p|
      p.click
#      p.fire_event("onmouseover")
      p.hover
      p chartelement << @browser.div(:id,"xwt_widget_charting_widget__MasterDatatip_0").div(:class,"dijitTooltipContainer dijitTooltipContents").text
      sleep 3
    end
    chartelement = chartelement.uniq
    puts "Chart tootl tip value-#{chartelement}"
    sleep 3
    if chartelement.empty?
      puts "Failure-Chart does not show the tool tip value"
      return false
    else
      puts chartelement
      puts"Success-Chart show the tool tip value"
      return true
    end

  end

end
