class GenericDashboardPage < AppPage

  div(:metric_panel) {self.div_elements(:class=>'metricPanel').visible_only.first}

  div(:dashboard_filter_panel) do |page|
    filter_panel = nil
    3.times do
      filter_panel = page.div_elements(:class=>'dashboardFilter').visible_only.first
      break if filter_panel
      sleep 1
    end
    raise "Dashboard Filter not present" unless filter_panel
    filter_panel
  end

  div(:dashboard) do |page|
    sleep 1 # for FF and GC
    dashboard = nil
    3.times do
      dashboard = page.div_elements(:class=>'tabContentPane').visible_only.first ||
      page.div_elements(:class=>'wap-dashboardLayout').visible_only.first
      #dashboard = page.div_elements(:class=>'wap-dashboardLayout').visible_only.first
      break if dashboard
      sleep 1
    end
    raise "Dashboard not present" unless dashboard
    dashboard
  end

  def goto
  end

  def loaded?(*how)
    dashboard_element.exists?
  end

  def metric_dashlets
    self.metric_dashlets_in metric_panel_element
  end

  def global_filters
    begin
      self.global_filters_in dashboard_filter_panel_element
    rescue #yes this is bad
      []
    end
  end

  def dashlets
    self.dashlets_in dashboard_element
  end

  def dashlet(dashlet_title)
    self.wait_until(10, "Dashlet not found") do
      center_object_in_wap self.dashlet_in(dashboard_element, dashlet_title)
    end
  end

end
