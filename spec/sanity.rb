require './spec/spec_helper.rb'

describe "Quick Tests" do
  
  it "should click on homepage tabs" do
    homepage = visit(HomePage)
    homepage.errors_and_discards_tab_element.click
    homepage.hint_icon_element.wait_until_present(10).click
  end
  
  
end