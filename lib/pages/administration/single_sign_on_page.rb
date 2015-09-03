class SingleSignOn < AppPage

  #PageObjects for SSO UI
#  span(:titlepage,:class=>"xwtBreadcrumbText xwtBreadcrumbLast")
  div(:ssoContent,:class=>"xwtTitlePaneContentOuter fbNoTitleSection")
  checkbox(:ssoCheckBox,:id=>"chk_enablesso")

  div(:serverIPDisable,:class=>"dijitTextBoxDisabled dijitDisabled",:index=>0)
  div(:portDisable,:class=>"dijitTextBoxDisabled dijitDisabled",:index=>1)

  text_field(:serverIPEnable,:class=>"dijitReset dijitInputInner",:index=>0)
  text_field(:portEnable,:class=>"dijitReset dijitInputInner",:index=>1)
  span(:testConnection,:id=>"btn_txtcon_label")
  span(:ssoClear,:id=>"btn_clear_label",:text=>"Clear")
  span(:ssoClearDisable,:class=>"xwt-TextButtonDisabled dijitDisabled",:index=>1)
  span(:ssoApply,:id=>"btn_submit_label")
  
  def goto
    navigate_application_to "Administration=>Single Sign-On"
  end

  def loaded?(*how)
    ssoContent_element.present?
  end

  def singleSignOn_AddFavourite
    self.ssoContent_element.flash
    self.favouriteIcon_element.flash.click
    self.toggleIcon_element.flash.click
    self.favouriteMenu_element.flash.click
    self.favouriteTitles_element.flash
    allTitle=[]
    all=@browser.div(:class=>"xwtSlideMenuFavoritesContainerNodeContainer").divs(:class=>"xwtSlideMenuMenuItemText")
    all.each do |p|
      allTitle<<p.text
    end
    return allTitle
  end

  def singleSignOn_RemoveFavourite
    self.favouriteIcon_element.flash.click
    self.toggleIcon_element.flash.click
    self.favouriteMenu_element.flash.click
    self.favouriteTitles_element.flash
    begin
      allTitle=[]
      all=@browser.div(:class=>"xwtSlideMenuFavoritesContainerNodeContainer").divs(:class=>"xwtSlideMenuMenuItemText")
      all.each do |p|
        allTitle<<p.text
      end
      return allTitle
    rescue
      puts"Page name is not displayed under Favourite List"
    end
  end

end
