module CommonAction
  include PageObject

  #Page object for Save Filters dijitDialog - Event Reports
  span(:saveBt,:id=>"saveBt")
  div(:dijitDialog,:class=>"xwtDialog dijitDialog")
  text_field(:filterTitle){dijitDialog_element.div(:class=>"dijitInputField dijitInputContainer").text_field(:class=>"dijitReset dijitInputInner")}
  textarea(:filterdesc){dijitDialog_element.textarea(:name=>"desc")}

  #Page object for export - Event Reports
  label(:reportexport,:class=>"i18nReplaceValue")
  span(:scheduleReportOption,:text=>"Schedule Report")
  text_field(:reportTitleBox){dijitDialog_element.text_field(:name=>"title")}
  span(:exportOption,:text=>"Export",:index=>2)

  def radioButton_click(radiobutton)
    if radiobutton.checked?
      puts "#{radiobutton} is already checked ..."
    else
      puts "Selecting Checkbox:= #{radiobutton}"
      radiobutton.click
    end
  end

  def click_button(element_name)
    begin
      element_name.when_present.flash.click
    rescue
      raise "#{element_name} not available on the page"
    end
  end

  def save_Filter(title,button)
    saveBt_element.flash.click
    filterTitle_element.set(title)
    filterdesc_element.set"Filter Description"
    div_element(:class=>"xwtDialog dijitDialog").span(:text=>button).flash.click
  end

  def Reports_scheduleReport(title,button)
    reportexport_element.flash.click
    scheduleReportOption_element.flash.click
    reportTitleBox_element.set(title)
    div_element(:class=>"xwtDialog dijitDialog").span(:text=>button).flash.click
  end

  def Reports_export(ind,button)
    reportexport_element.flash.click
    exportOption_element.flash.click
    div_element(:class=>"xwtDialog dijitDialog").span(:class=>"dijitReset dijitInline dijitButtonText",:index=>ind,:text=>button).flash.click
  end

end