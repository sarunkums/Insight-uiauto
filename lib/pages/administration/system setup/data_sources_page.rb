class DataSourcesPage < AppPage

  a(:dataSource,:class=>"xwtSlideMenuMenuItemLink",:text=>"Data Sources")
  span(:deleteDataSource,:title=>"Delete")
  span(:rowSelection,:class=>"selectionCountLabel")
  div(:firstRow,:class=>"row-0")
  div(:firstRowCell1){firstRow_element.div_element(:class=>"cell-1")}
  div(:firstRadio){firstRow_element.div_element(:class=>"cell-0").radio(:class=>"selection-input")}
  div(:datasourceTable,:class=>"table")
  div(:datasourceTableToolbar,:class=>"xwtGlobalToolbar")

  def goto
    navigate_application_to "Administration=>System Setup=>Data Sources"
  end

  def loaded?(*how)
    pageTitle_element.present?
  end

  def dataSourceIPDetails
    ipAddress=[]
    all=@browser.div(:class=>"table-container").divs(:class=>"row")
    all.each do |p|
      p.div(:class=>"cell-1").flash
      ipAddress<<p.div(:class=>"cell-1").text
    end
    return ipAddress
  end

  def slideMenuPages
    sleep 2
    slidMenu=[]
    all=@browser.div(:class=>"xwtSlideMenuNavgationMenuChunk").divs(:class=>"xwtSlideMenuMenuItem")
    all.each do |p|
      slidMenu<<p.div(:class=>"xwtSlideMenuMenuItemText").text
    end
    return slidMenu
  end

  def dataSourceColumnDetails
    sleep 2
    allcolumns=[]
    all=@browser.div(:class=>"table-head-node-container").tds(:class=>"cell-container")
    all.each do |p|
      allcolumns<<p.div(:class=>"cellHeaderWrapper").text
    end
    allcolumns<<@browser.div(:class=>"table-head-node-container").td(:class=>"cell-container",:index=>4).text
    return allcolumns
  end

end