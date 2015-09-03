class LicenseManagementPage < AppPage

  div(:title,:class=>"pageTitleLabel")
  def goto
    navigate_application_to "Administration=>License Management"
  end

  def loaded?(*how)
    title_element.present?
  end

end