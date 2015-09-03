module Table
  include PageObject
    
  #public
  def header_row_of(xwttable)
    xwttable.div_element(:class=>'table-header-container').table_elements.first
  end
    
  def rows_of(xwttable, how = :no_header)
    rows = xwttable.div_element(:class=>'table-body').div_elements(:class=>'row')
    rows.unshift header_row_of xwttable if how == :with_header
    rows
  end
  
  def row_containing(text, xwttable)
    rows_of(xwttable).select{|r| r.text.include? text}.first
  end
  
  def cells_of(row)
    row.div_elements(:class=>'cell')
  end

  def table_textual_content_of(xwttable, how = :no_header)
    rows_of(xwttable, how).map do |row|
      cells_of(row).map { |c| c.text }
    end
  end
  
  def headers_of(xwttable)
    xwttable.table_element(:class=>"table-header").cell_elements(:class=>"cell-container").visible_only.collect {|cell| cell.text.strip}
  end
  
  def table_refresh(globaltoolbar)
    globaltoolbar.span_element(:id=>/_xwtTableGlobalToolbar_refreshButton/).click
  end
  
  def toggle_all_columns_visibility(globaltoolbar)
    globaltoolbar.span_element(:id=>/_xwtTableGlobalToolbar_settingsButton/).click
    table_settings_menu.row(:text=>/Columns/).click
    self.table_elements(:class=>"xwtTableColumnsMenu").visible_only.last.td(:class=>"xwtColumnsMenuHolder").table.rows(:class=>"dijitMenuItem").each { |item| item.hover if $browser_type==:ie9; item.click }
    globaltoolbar.span_element(:id=>/_xwtTableGlobalToolbar_settingsButton/).click
  end

  def toggle_visibility_for_column(globaltoolbar, column)
    globaltoolbar.span_element(:id=>/_xwtTableGlobalToolbar_settingsButton/).click
    table_settings_menu.row(:text=>/Columns/).click
    self.table_elements(:class=>"xwtTableColumnsMenu").visible_only.last.td(:class=>"xwtColumnsMenuHolder").table.row(:class=>"dijitMenuItem", :text=>/#{column}/).click
    globaltoolbar.span_element(:id=>/_xwtTableGlobalToolbar_settingsButton/).click
  end
  
  def sort_by_column(xwttable, column)
    xwttable.table_element(:class=>"table-header").cell_element(:class=>"cell-container", :text=>column).click
  end
  
  def click_all_rows_selection_for(xwttable)
    header_row_of(xwttable).div_element(:class=>'xwtSelectAll').checkbox_element.click
  end
  
  def select_rows(xwttable, range)
    range = range..range unless range.kind_of?(Range) #transform single index into a range
    rows_of(xwttable)[range].each{|row| select_row row }
  end
  
  def selected_rows(xwttable)
    rows_of(xwttable).select {|row| row.visible? && is_selected?(row) }
  end
  
  def select_row(row)
    checkbox = row.checkbox_element(:class=>"selection-input")
    radio = row.radio_button_element(:class=>"selection-input")
    checkbox.check if checkbox.exists?
    radio.select if radio.exists?
    sleep 0.5 if $browser_type == :gc
  end
  
  def is_selected?(row)
    checkbox = row.checkbox_element(:class=>"selection-input")
    radio = row.radio_button_element(:class=>"selection-input")
    return checkbox.checked? if checkbox.exists?
    return radio.selected? if radio.exists?
  end
  
  def selection_count(globaltoolbar)
    globaltoolbar.span_element(:class=>'selectionCountLabel').text =~ /Selected (\d+)/
    $1.to_i
  end

  def total_count(globaltoolbar)
    globaltoolbar.span_element(:class=>'totalCountLabel').text =~ /Total (\d+)/
    $1.to_i
  end
  
  def fix_rows(xwttable, globaltoolbar, range)
    select_rows(xwttable, range)
    globaltoolbar.span_element(:id=>/_xwtTableGlobalToolbar_settingsButton/).click
    table_settings_menu.row(:text=>/Fix Row/).click
    self.table_elements(:id=>/dijit_Menu_/).visible_only.last.row(:class=>"dijitMenuItem", :text=>/Fix to Bottom/).click
    sleep 1
  end

  def fixed_rows(xwttable)
    xwttable.div_element(:class=> "table-row-locked-container-bottom").div_elements(:class=>'row')
  end

  def table_settings_menu
    self.table_elements(:class=>"xwtTableSettingsMenu").visible_only.last
  end
  
  def delete_rows(xwttable, contextualtoolbar, range)
    select_rows(xwttable, range)
    contextualtoolbar.span_element(:id=>/_xwtTableContextualToolbar_deleteButton/).click
  end
  
  def set_quick_filter_column_to(xwttable, column, value)
    quickfilter = xwttable.div_element(:class=>'filter-by-example')
    columnidx = quickfilter.cell_element(:text=>column).attribute_value "columnidx"
    filter = quickfilter.div_element(:class=>'xwtFilterByExample').div_element(:class=>"cell-#{columnidx}")
    if value == "" then
      filter.div_element(:class=>'xwtByExampleWidgetButton').click  #clear filter
    else
      filter.text_field_elements[1].set value                       #set filter
    end
    sleep 2
  end
  
  def preset_filter(toolbar)
    toolbar.table_element(:class=>"xwtQuickFilterSelect").text
  end
  
  def change_preset_filter_to(toolbar, value)
    toolbar.table_element(:class=>"xwtQuickFilterSelect").click
    self.table_elements(:class=>"xwtTableQuickFilterMenu").visible_only.last.div_element(:text=>value).click
    sleep 2
  end
  
  def add_advanced_filter(filter_toolbar, column, operator, criteria = "")
    filter_row = filter_toolbar.table_elements(:class=>"xwtFilterWidget").last
    unless filter_row.cell_element(:class=>"column-cell").span_element.text.strip.empty?
      filter_row.span_element(:class=>'dijitButtonContents', :title=>"add").click
      filter_row = filter_toolbar.table_elements(:class=>"xwtFilterWidget").last
    end
    filter_row.cell_element(:class=>"column-cell").table_element(:class=>"xwtDropDown").click
    self.table_elements(:class=>"dijitSelectMenu").visible_only.last.cell_element(:text=>column).click
    filter_row.cell_element(:class=>"operator-cell").table_element(:class=>"xwtDropDown").click
    self.table_elements(:class=>"dijitSelectMenu").visible_only.last.cell_element(:text=>operator).click
    if filter_row.cell_element(:class=>"criteria-cell").div_element.visible?
      filter_row.cell_element(:class=>"criteria-cell").div_element(:class=>'dijitInputField').text_field_element.set criteria
    end
    filter_toolbar.span_element(:class=>'dijitButtonContents', :text=>/Go/).click
    sleep 2
  end
  
  def buttons_in_toolbar(contextualtoolbar)
    contextualtoolbar.span_elements(:class=>"dijitButtonNode").collect do |b| 
      title = b.span_element(:class=>"dijitButtonContents").title
      text = b.span_element(:class=>"dijitButtonText").text
      if title == "" then text else title end
    end
  end

  def enabled_buttons_in_toolbar(contextualtoolbar)
    contextualtoolbar.span_elements(:class=>"dijitButtonNode").collect do |b|
      if b.parent.class_name.include? "dijitDisabled" then nil
      else
        title = b.span_element(:class=>"dijitButtonContents").title
        text = b.span_element(:class=>"dijitButtonText").text
        if title == "" then text else title end
      end
    end
  end
  
  def click_button_in(contextualtoolbar, label)
    contextualtoolbar.span_elements(:class=>"dijitButtonNode").select do |b| 
      title = b.span_element(:class=>"dijitButtonContents").title
      text = b.span_element(:class=>"dijitButtonText").text
      title == label || text == label
    end.first.click
  end
  
  def add_row_in(contextualtoolbar)
    click_button_in(contextualtoolbar, "Add Row")
  end
  
  def delete_row_in(contextualtoolbar)
    click_button_in(contextualtoolbar, "Delete")
  end
  
  def edit_row_in(contextualtoolbar)
    click_button_in(contextualtoolbar, "Edit")
  end
  
  def row_editor_in(xwttable)
    xwttable.div_element(:class=>'row-editor')
  end
  
  def row_editor_save_in(xwttable)
    row_editor_in(xwttable).link_element(:text=>"Save").click
  end
  
  def row_editor_cancel_in(xwttable)
    row_editor_in(xwttable).link_element(:text=>"Cancel").click
  end
  
  # XWT DataGrid APIs
  def datagrid_rows_of(datagrid)
    datagrid.div_elements(:class=>'dojoxGridRow') #.visible_only    visible_only not really needed in this case.. removing for performances reason, on IE: 7s instead of 24s
  end

  def datagrid_sort_by_column(datagrid, column)
    #doesnt work in FF and IE9
    datagrid.div_elements(:class=>"dojoxGridMasterHeader").visible_only.first.div_element(:class=>"dojoxGridSortNode", :text=>/#{column}/).click
  end
  
  def datagrid_select_rows(datagrid, range)
    range = range..range unless range.kind_of?(Range) #transform single index into a range
    datagrid_rows_of(datagrid)[range].each{|row| datagrid_select_row row }
  end
  
  def datagrid_selected_rows(datagrid)
    datagrid_rows_of(datagrid).select {|row| row.visible? && datagrid_is_selected?(row) }
  end
  
  def datagrid_select_row(row)
    #checkbox = row.checkbox_element(:class=>"dijitCheckBoxInput")
    checkbox = row.div_element(:class=>"dijitCheckBox")
    #radio = row.radio_button_element(:class=>"selection-input")
    checkbox.click if checkbox.exists?
    #radio.select if radio.exists?
  end
  
  def datagrid_is_selected?(row)
    #checkbox = row.checkbox_element(:class=>"dijitCheckBoxInput")
    checkbox = row.div_element(:class=>"dijitCheckBox")
    #radio = row.radio_button_element(:class=>"selection-input")
    return checkbox.attribute("aria-checked")=="true" if checkbox.exists?
    #return radio.selected? if radio.exists?
  end


end
# module PageObject
  # module Elements
    # class XwtTable < Element
# 
      # protected
      # def self.watir_finders
        # super + [:text, :title]
      # end
# 
      # def self.selenium_finders
        # super + [:text, :title]
      # end
# 
    # end
# 
    # ::PageObject::Elements.tag_to_class[:xwttable] = ::PageObject::Elements::Div
  # end
# end
# 
# module PageObject
  # #
  # # Contains the class level methods that are inserted into your page objects
  # # when you include the PageObject module.  These methods will generate another
  # # set of methods that provide access to the elements on the web pages.
  # #
  # # @see PageObject::WatirPageObject for the watir implementation of the platform delegate
  # # @see PageObject::SeleniumPageObject for the selenium implementation of the platform delegate
  # #
  # module Accessors
    # #
    # # adds three methods - one to retrieve the text from a div,
    # # another to return the div element, and another to check the div's existence.
    # #
    # # @example
    # #   div(:message, :id => 'message')
    # #   # will generate 'message', 'message_element', and 'message?' methods
    # #
    # # @param [Symbol] the name used for the generated methods
    # # @param [Hash] identifier how we find a div.  You can use a multiple paramaters
    # #   by combining of any of the following except xpath.  The valid keys are:
    # #   * :class => Watir and Selenium
    # #   * :id => Watir and Selenium
    # #   * :index => Watir and Selenium
    # #   * :name => Watir and Selenium
    # #   * :text => Watir and Selenium
    # #   * :title => Watir and Selenium
    # #   * :xpath => Watir and Selenium
    # # @param optional block to be invoked when element method is called
    # #
    # def xwttable(name, identifier={:index => 0}, &block)
      # define_method(name) do
        # return platform.div_text_for identifier.clone unless block_given?
        # self.send("#{name}_element").text
      # end
      # define_method("#{name}_element") do
        # return call_block(&block) if block_given?
        # platform.div_for(identifier.clone)
      # end
      # define_method("#{name}?") do
        # return call_block(&block).exists? if block_given?
        # platform.div_for(identifier.clone).exists?
      # end
      # alias_method "#{name}_xwttable".to_sym, "#{name}_element".to_sym
    # end
#     
  # end
# end