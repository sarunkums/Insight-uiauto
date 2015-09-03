require 'json'

module FlexElement

  @flex_id
  @browser
  def initialize(flex_object_id, browser)
    @flex_id = flex_object_id
    @browser = browser
    @browser.element(:id => flex_object_id).when_present
    #wait for flex object loading
    more = 12
    begin
      sleep 5
      more -= 1
      raise "Could not load the Flash object with id '#{flex_object_id}'" if more==0
    end until loaded?
  end

  def call(function, *args )
    a = (args!=[]) ? "'" + args.join("','") + "'" : nil
    #puts "---- FlexElement.call: document['#{@flex_id}'].#{function}(#{a})"

    @browser.driver.execute_script("return document['#{@flex_id}'].#{function}(#{a})")
  rescue => e
    puts e.message
  end

  def loaded?
    call("PercentLoaded") == 100
  end

  def version
    call("CelestaExternalAPI_getVersion")
  end
end

class TreeTable
  include FlexElement
  def exists?
    call("UIComponent_exists", "CiscoGrid:") == true
  end

  def title
    call "TreeTable_getTitle", "CiscoGrid:"
  end

  def data
    r = call "TreeTable_getData", "CiscoGrid:"
    cells = JSON.parse r
    out={}
    cells.each do |cell|
      if cell["data"] != "" then
        out[cell["data"]] = cell
      end
    end
    out
  end

  def scrolldown
    init_pos = call "TreeTable_getScrollPosition", "CiscoGrid:"
    call "TreeTable_scrollPage", "CiscoGrid:", "down"
    fin_pos = call "TreeTable_getScrollPosition", "CiscoGrid:"
    fin_pos != init_pos
  end

  def scrollup
    init_pos = call "TreeTable_getScrollPosition", "CiscoGrid:"
    call "TreeTable_scrollPage", "CiscoGrid:", "up"
    fin_pos = call "TreeTable_getScrollPosition", "CiscoGrid:"
    fin_pos != init_pos
  end

  def scroll_to_top
    {} while scrollup
  end

  def scroll_to_bottom
    {} while scrolldown
  end

  def expand_all
    begin
      all_expanded_in_current_page = true
      while all_expanded_in_current_page
        r = call "TreeTable_getExpandos", "CiscoGrid:"
        cells = JSON.parse r
        #puts "=================="
        #puts cells
        #puts "=================="

        all_expanded_in_current_page = false
        cells.each do |c|
          #  puts c
          if (c["hasChildren"]==true) && (c["expanded"]==false) then
            call "UIComponent_mouseOver", "CiscoGrid: ExpandCollapseIcon:" + c["rendererName"]
            call "UIComponent_click", "CiscoGrid: ExpandCollapseIcon:" + c["rendererName"]

            all_expanded_in_current_page = true
            sleep 1
            break #restart cycle from scratch because object names have changed
          end
        end
      end
    rescue => e
      puts e.message
      puts e.inspect
      puts "----"
      puts e.backtrace.join("\n")
    end while scrolldown
  end

  def select(label)
    sleep 5
    expand_all
    scroll_to_top
    cells = data()
    while !cells[label] do
      raise "#{label} not found" if !scrolldown
      cells = data()
    end
    puts cells[label]
    row_to_select = cells[label]["row"]

    r = call "TreeTable_getSelectionCheckboxes", "CiscoGrid:"
    checkboxes = JSON.parse r
    cbs = checkboxes.select{ |c| (c["row"]==row_to_select) && (c["selectedState"]=="unchecked") }
    #the first row checkbox and the select all checkbox have the same fields.. so we need to get all rows and select the last one
    #puts "FOUND #{cbs.size} checkboxes"
    if cbs && cbs.last
      call "UIComponent_mouseOver", "CiscoGrid: TriStateCheckBox:" + cbs.last["rendererName"]
      call "UIComponent_click", "CiscoGrid: TriStateCheckBox:" + cbs.last["rendererName"]
    end
  end

  def toolbar_buttons
    r = call "TreeTableContextToolbar_getButtons", "CiscoGrid: CiscoToolBar:null HBox:contextBar"
    return [] unless r
    buttons = r.split(';').collect {|b| b.split('|')[1]}
  end

  def click_toolbar_button(label)
    r = call "TreeTableContextToolbar_getButtons", "CiscoGrid: CiscoToolBar:null HBox:contextBar"
    raise "No buttons found" unless r
    buttons = r.split(';')
    button = buttons.select {|b| b.split('|')[1].include? label}
    raise "Button '#{label}' not found" if button.size == 0
    raise "More than one button '#{label}' was found" unless button.size==1
    button_label = button[0].split('|')[0]
    call "UIComponent_mouseOver", "CiscoGrid: Label:" + button_label
    call "UIComponent_click", "CiscoGrid: Label:" + button_label
  end

  def global_buttons
    r = call "TreeTableGlobalToolbar_getButtons", "CiscoGrid: CiscoToolBar:null Canvas:globalBar"
    return [] unless r
    buttons = r.split(';').collect {|b| b.split('|')[1]}
  end

  def click_global_button(label)
    r = call "TreeTableGlobalToolbar_getButtons", "CiscoGrid: CiscoToolBar:null Canvas:globalBar"
    raise "No buttons found" unless r
    buttons = r.split(';')
    button = buttons.select {|b| b.split('|')[1].include? label}
    raise "Button '#{label}' not found" if button.size == 0
    raise "More than one button '#{label}' was found" unless button.size==1
    button_label = button[0].split('|')[0]
    call "UIComponent_mouseOver", "CiscoGrid: Button:" + button_label
    call "UIComponent_click", "CiscoGrid: Button:" + button_label
  end

end

