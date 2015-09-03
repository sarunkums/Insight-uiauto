module TaskNavigator
  include PageObject
  
  def tasks_in(task_navigator_widget)
    task_navigator_widget.div_elements(:class=>'Task').collect{|d| d.text}
  end

  def task(task_navigator_widget, label)
    task_navigator_widget.div_elements(:class=>'Task').select{|d| d.text.include? label}[0]
  end

  def select_task(task_widget)
    task_widget.div_element(:class=>'TaskButton').click
  end

  def active_task_in(task_navigator_widget)
    task_navigator_widget.div_element(:class=>'TaskActive').text
  end
  
  def task_complete?(task_widget)
    task_widget.class_name.include? 'TaskProgressCompleted'
  end

end