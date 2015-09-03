module Chart
  include PageObject

  #Page object for CHART ToolTip
  div(:tooltipHeader,:id =>"xwt_widget_charting_widget__MasterDatatip_0")
  div(:tooltipValue){tooltipHeader_element.div(:class =>"dijitTooltipContainer dijitTooltipContents")}

  def value_filter_of(dashlet)
    dashlet.div_element(:class=>"topActionNode", :index=>0).div_element(:class=>"selected").text
  end

  def set_value_filter_of(dashlet, value)
    dashlet.div_element(:class=>"topActionNode", :index=>0).div_element(:class=>'actionItem', :text=>value).click
  end

  def time_filter_of(dashlet)
    dashlet.div_element(:class=>"topActionNode", :index=>1).div_element(:class=>"selected").text
  end

  def set_time_filter_of(dashlet, value)
    dashlet.div_element(:class=>"topActionNode", :index=>1).div_element(:class=>"actionItem", :text=>value).click
  end

  def view_type_of(dashlet)
    case dashlet.div_element(:class=>"gridChartPanel").class_name
    when /showChart/ then return :chart
    when /showGrid/  then return :table
    else
      raise "Dashlet view type cannot be determined"
    end
  end

  def set_view_type_of(dashlet, type)
    dashlet.div_element(:class=>"#{type.to_s}Icon").click
  end

  def chart_type_of(dashlet)
    case dashlet.div_element(:class=>"chartActionIcon").class_name
    when /lineChartIcon/   then return :line
    when /columnChartIcon/ then return :column
    when /areaChartIcon/   then return :area
    else
      raise "Chart type cannot be determined"
    end
  end

  def set_chart_type_of(dashlet, type)
    dashlet.div_element(:class=>"chartActionIcon").click
    self.div_element(:class=>"xwtMoreActionPopup").div_element(:class=>"#{type.to_s}ChartIcon").click
    sleep 2
  end

  def inline_filter_elements_of(dashlet)
    dashlet.span_element(:class=>'filter').parent.span_elements(:class=>'linkadmin', :id=>/spn/)
  end

  def chart_in(dashlet)
    dashlet.div_element(:class=>'chartNode')
  end

  def grid_in(dashlet)
    [dashlet.div_element(:class=>'gridNode'),
      dashlet.div_element(:class=>'table')].select {|d| d.exists?}.first
  end

  def svg_for(chart)
    chart.html.gsub(/dojoxUnique(\d*)/, "")
  end

  def chart_tooltip
    sleep 0.5 # GC on Mac is too fast
    @browser.divs(:class=>'dijitTooltip').visible_only.last
  end

  def report_Chart(chartTag)
    sleep 5
    div_element(:id=>"chartContainer").div_element(:class=>"bottomRegion").div_element(:title => "Grid Mode").click
    div_element(:id=>"chart").wd.location_once_scrolled_into_view
    grid_count=[]
    div_element(:id=>"chartContainer").div_element(:class=>"gridNode").div_element(:class=>"dojoxGridView").divs(:class => /dojoxGridRow/).each do |p|
    grid_count << p.table(:class=>"dojoxGridRowTable").tr.td(:class => /dojoxGridCe/, :index => 0).text
    end
    grid_count = grid_count.uniq
    if grid_count.size == 1 # This case would handle when only single slice on dashlet
      div_element(:id=>"chartContainer").div_element(:class=>"bottomRegion").div_element(:title =>"Chart Mode").click
      sleep 3
      all_rect_line =div_element(:class => "chartNode").elements(:css => "g")
      charttooltip=[]
      all_rect_line.each do |p|
        if p.element(:css => chartTag).exists?
          p.element(:css => chartTag).click
          charttooltip << self.tooltipValue_element.text
        end
        puts "Chart tooltip value: #{charttooltip}"
        return charttooltip
      end
    else
      div_element(:id=>"chartContainer").div_element(:class=>"bottomRegion").div_element(:title => "Chart Mode").click
      sleep 3
      all_rect_line = div_element(:class=>"chartNode").elements(:css => "g")
      charttooltips = []
      all_rect_line.each do |p|
        if p.element(:css => chartTag).present?
          p.elements(:css => chartTag).each do |rec|
            rec.click
            charttooltips << self.tooltipValue_element.text
          end
          finalcharttooltipsValue = charttooltips.uniq
          puts "Chart tooltip value: #{finalcharttooltipsValue}"
          return finalcharttooltipsValue
        end
      end
    end
  end
end