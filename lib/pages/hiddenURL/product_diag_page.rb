class ProductDiagPage < AppPage

  div(:page_content,:class=>"content")
  h1(:page_title,:class=>"pageTitle")
  link(:diskfree, :text=>"Server Disk Free Info")
  link(:memory, :text=>"Server Memory Info")
  link(:cpu, :text=>"Server CPU Info")
  link(:diskio, :text=>"Server Disk IO Info")
  link(:process, :text=>"Server Process Info")
  link(:topprocess, :text=>"Top Processes")
  link(:netstat, :text=>"Netstat Info")
  button(:refresh, :text=>"Refresh")
  button(:back, :text=>"Back")
  def loaded?(*how)
    @browser.table.present?
  end

  def PageTitle
    title = self.page_title_element.text
    puts "Title: #{title}"
    return title
  end

  def diskfreeinfo
    self.diskfree_element.click
    if (@browser.u(:text=>"System Disk Free Info").present? && @browser.pre(:index=>0).present?)
      return true
    else
      return false
    end
  end

  def memoryinfo
    self.memory_element.click
    if (@browser.u(:text=>"System Memory Info").present? && @browser.pre(:index=>0).present?)
      return true
    else
      return false
    end
  end

  def cpuinfo
    self.cpu_element.click
    if (@browser.u(:text=>"System CPU Info").present? && @browser.pre(:index=>0).present?)
      return true
    else
      return false
    end
  end

  def diskioinfo
    self.diskio_element.click
    if (@browser.u(:text=>"System Disk IO Info").present? && @browser.pre(:index=>0).present?)
      return true
    else
      return false
    end
  end

  def processinfo
    self.process_element.click
    if (@browser.u(:text=>"List of Processes").present? && @browser.pre(:index=>0).present?)
      return true
    else
      return false
    end
  end

  def topprocessinfo
    self.topprocess_element.click
    if (@browser.u(:text=>"Top Processes").present? && @browser.pre(:index=>0).present?)
      return true
    else
      return false
    end
  end

  def netstatinfo
    self.netstat_element.click
    if (@browser.u(:text=>"Netstat Info").present? && @browser.pre(:index=>0).present?)
      return true
    else
      return false
    end
  end

  def click_refresh
    if self.refresh_element.present?
      self.refresh_element.flash.click
      return true
    end
  end

  def click_back
    if self.back_element.present?
      self.back_element.flash.click
      sleep 2
      return true
    end
  end

end