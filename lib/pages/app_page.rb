class  AppPage
  include Widgets
  include PageObject
  include PageFactory

  #  include Sapphire
  #  include Watir

  div(:header, :class=>'headerNode')
  div(:close, :class=> 'xwtPopoverClose icon-close xwtPopoverButton')
  div(:settings, :class=>'settingsNode')
  div(:settings_menu, :class=>'xwtPopupSlideMenuPopover')
  div(:user, :class=>'settingLoginLabel', :index=>0)
  div(:startup_dialog, :class=>'xwtDialog', :text=>/Introducing Prime/)
  span(:pageTitle,:class=>"xwtBreadcrumbText xwtBreadcrumbLast")

  #Page object for delete alert
  div(:alert,:class=>"dijitDialog xwtAlert")
  span(:deletealertOK){alert_element.span(:text=>"OK")}
  span(:deletealertCancel){alert_element.span(:text=>"Cancel")}

  span(:alertYES){alert_element.span(:text=>"Yes")}
  span(:alertNO){alert_element.span(:text=>"No")}
  div(:alertText){alert_element.div(:class=>"xwtAlert-warning")}

  #Page Object for Evaluation Period Alert
  div(:evaluationAlert,:class=>"xwtAlert")
  span(:evaluationOK){evaluationAlert_element.span(:text=>"OK")}

  #Page object for toggle icon and Favorite,Pages Link
  div(:favouriteIcon,:class=>"xwtNavBreadcrumbFavoriteIcon icon-star")
  div(:toggleIcon,:class=>"toggleIcon icon-cisco-menu")
  span(:favouriteMenu,:class=>"navFontIcon fi-star")
  div(:favouriteTitles,:class=>"xwtSlideMenuFavoritesContainerNodeContainer")
  div(:administradion,:class=>"xwtSlideOutNavigationButtonTitle",:text=>"Administration")

  #Page object for Table SETTINGS
  span(:tableSetting,:title=>"Settings")
  td(:tableColumn,:text=>"Columns")
  div(:columnDetails,:class=>"dijitPopup dijitMenuPopup",:index=>1)
  div(:firstColumn){columnDetails_element.tr(:index=>1)}
  div(:secondColumn){columnDetails_element.tr(:index=>2)}
  span(:resetColumn,:class=>"dijitReset dijitInline dijitButtonText",:text=>"Reset")
  span(:closeColumn,:class=>"dijitReset dijitInline dijitButtonText",:text=>"Close")

  #Page object for globaladmin
  div(:globaladmin,:class=>"settingLoginLabel",:text=>"globaladmin")
  td(:gettingstart,:id=>"gettingStarted_text",:text=>"Getting Started")
  td(:helpus,:id=>"helpus_text",:text=>"Help US to Improve CISCO Product")

  def goto
  end

  def initialize_page
    begin
      wait_until(30, "Application page not loaded correctly after 15s.") { loaded? }
      # rescue Watir::Wait::TimeoutError
      #   puts "WARNING: Application stuck.. Trying to refresh"
      #   @browser.refresh
      #   wait_until(30, "Application page not loaded correctly after 10s, refresh and other 10s.") { loaded? }
      #   puts "NOW loaded" # should not reach this if it times out again
    end
  end

  def loaded?(*how)
    puts "loaded header"
    # use how to specify different meanings of loaded?
    # e.g.
    # if how.include? :with_initial_content then
    # else
    # end
    header_element.visible? # && user_element.present?
  end

  def view_content_loaded?(view)
    view.present? && view.text != "" && view.text !~ /Loading/
  end

  def open_settings
    dismiss_startup_dialog_if_present(1) # shouldnt be needed here, but..
    settings_element.click unless settings_menu_element.visible?
    sleep 1
    settings_menu_element.when_present
  end

  def dismiss_startup_dialog_if_present(timeout=3)
    begin
      wait_until(timeout) { startup_dialog_element.visible? }
      puts "DEBUG: Closing Startup Dialog" if $SAPPHIRE_DEBUG
      close_dialog startup_dialog_element
    rescue Watir::Wait::TimeoutError => te
      puts "DEBUG: Startup Dialog not found" if $SAPPHIRE_DEBUG
      #not present, hopefully
    end
    startup_dialog_element.when_not_present
  end

  def open_preferences
    settings_menu = open_settings
    settings_menu.td(:text=>"Preferences").click
    expect_dialog('Preferences')
  end

  def reset_page_preferences
    dialog = open_preferences
    reset_page = dialog.div_element(:id=>'resetPagePrefsDiv').radio_button_element
    if reset_page.selected?
      puts "WARNING: Reset Page Preferences radio button is already checked! Skipping"
      dialog.span_element(:class=>'dijitDialogCloseIcon').click
    else
      reset_page.click
      dialog.span_element(:class=>'xwtButton', :text=>/Done/).span_element.click
    end
    dialog.wait_while_present
    initialize_page
  end

  def reset_all_preferences
    dialog = open_preferences
    reset_all = dialog.div_element(:id=>'radioDiv').radio_button_element
    if reset_all.selected?
      puts "WARNING: Reset All Preferences radio button is already checked! Skipping"
      dialog.span_element(:class=>'dijitDialogCloseIcon').click
    else
      reset_all.click
      dialog.span_element(:class=>'xwtButton', :text=>/Done/).span_element.click
    end
    dialog.when_not_present
    initialize_page
    dismiss_startup_dialog_if_present
  end

  def current_user
    user_element.text
  end

  def open_theme_menu
    settings_menu = open_settings
    settings_menu.td(:class=>"dijitMenuItemLabel", :text=>/Theme/).click
    expect_popover("Back")
  end

  def current_theme
    settings_menu = open_settings
    settings_menu.td(:class=>"dijitMenuItemLabel", :text=>/Theme/).text.split[1]
  end

  def change_theme_to(new_theme)
    return if new_theme == current_theme
    theme_menu = open_theme_menu
    theme_menu.td(:text=>new_theme).click
    initialize_page
  end

  def logout
    settings_menu = open_settings
    settings_menu.td(:text=>'Log out').when_present.click
  end

  def open_domain_dialog
    settings_menu = open_settings
    settings_menu.td(:class=>"dijitMenuItemLabel", :text=>/Virtual Domain/).click
    expect_dialog("Domain")
  end

  def evaluation_alert
    puts"get into Evaluation alert"
    if(evaluationAlert_element.exists?)
      puts "Evaluation alert Present...Trying to CLOSE"
      evaluationOK_element.when_present.flash.click
      #      if $browser_type == :ie10
      #        evaluationOK_element.when_present.flash.click
      #      else
      #        puts"Running Browser is not an IE"
      #      end
      sleep 1
    else
      puts "Evaluation alert Not Appear"
    end
  end

  def close_the_popup

    if(close_element.exists?)
      puts "Getting Started popup exists...Trying to CLOSE"
      close_element.when_present(15).flash.click
      sleep 1
    else
      puts "Getting Started popup not appear"

    end
  end

  def button_enabled?(button)
    !(button.parent.class_name.include? "dijitDisabled")
  end

  # def about
  # about_element
  # end
  #
  # def close_about
  # about.span_element(:class => 'xwtIconButton').when_present.click
  # end

end
