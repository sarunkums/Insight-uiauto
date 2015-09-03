module TitlePane
  include PageObject

  def all_panes
    self.div_elements(:class=>"xwtTitlePaneTitle")
  end
  
  def panes
    all_panes.visible_only.collect{|pane| pane.text}
  end
  
  def pane(title)
    pane_title = all_panes.visible_only.select{|pane| pane.div_element(:class=>"xwtTitlePaneTextNode", :text=>title).present?}.first
    pane_title.parent
  end
  
  def has_pane_opened?(title)
    pane(title).div_element(:class=>'xwtTitlePaneTitle').class_name.include? 'dijitOpen'
  end
  
  def close_pane(title)
    pane(title).div_element(:class=>'xwtTitlePaneTitle').div_element(:class=>'xwtTitlePaneTextNode').click
  end
  
  def make_sure_all_panes_are_visible
    #get last pane and scroll it into view..
    #workaround probably required by latest selenium webdriver
    all_panes.last.wd.location_once_scrolled_into_view
  end
  
end