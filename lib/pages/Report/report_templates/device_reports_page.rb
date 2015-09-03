class DeviceReportsPage < AppPage

  #Page objects for error and Device Reports

  radio(:deviceGroup,:id=>"deviceGroup")
  radio(:deviceSeries,:id=>"deviceSeries")
  radio(:deviceType,:id=>"deviceType")

  div(:deviceGroupObjPicker,:id=>'deviceGroupObjPicker')
  div(:deviceObjPicker,:id=>'deviceObjPicker')
  div(:deviceSeriesObjPicker,:id=>'deviceSeriesObjPicker')
  div(:deviceTypeObjPicker,:id=>'deviceTypeObjPicker')

  span(:resetBt_label,:id=>"resetBt_label")
  span(:applyCloseBt_label,:id=>"applyCloseBt_label")
  span(:applyBt_label,:id=>"applyBt_label")

  div(:deviceReports,:id=>"deviceReports")
  #  div(:advanced_filter, :class=>"xwtFilteringToolbar")
  
  def goto
    navigate_application_to "Report=>Alarm Reports"
  end

  def device_report(value)

#    radioButton_click(deviceSeries_element)                             # This function for radio button click
#
#    open_and_set_picker_to(deviceSeriesObjPicker_element,"","")         # This function for to select the value from the dijitPopup
#    open_and_set_picker_to(deviceSeriesObjPicker_element, "", value)
#
#    click_button(applyBt_label_element)                                 # This function for button click
#    save_Filter("DeviceReportFilter","Save")                            # This function for Save Filter Dialog
#    Reports_scheduleReport("DeviceScheduleReport","Save")               # This function for Schedule Report
#    Reports_export(0,"Export")                                          # This function for Export Format
    
    report_Chart("rect")                                                       # This function for chart

    # toggle_visibility_for_column(deviceReports_element,"Serial Number") # This function for to select the Column Name from the table
    # add_advanced_filter(advanced_filter_element, "Device Name", "Contains", "prime-asr9k-cluster") # Not working need to check with stefano
    
  end
  
  def pie_chart(value)
    radioButton_click(deviceSeries_element)                             # This function for radio button click
    open_and_set_picker_to(deviceSeriesObjPicker_element,"","")         # This function for to select the value from the dijitPopup
    open_and_set_picker_to(deviceSeriesObjPicker_element, "", value)
    click_button(applyBt_label_element)    
    report_Chart("path")
  end
  
  
  
  
  
  
end