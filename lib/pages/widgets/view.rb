module View
  include PageObject

  def view(viewid)
    # applying the select causes the div_elements to be located, so if it doesnt exists, it is null
    # this does not allow to use view("myview").should_not be_present
    # to allow this, let's return a fake non existing element..  
    self.div_elements(:class=>"viewContainer").select{|v| v.attribute("viewid")==viewid }.first || @browser.div(:class=>"fakeElementToAllowCheckForViewNotPresent")
  end
  
end