require 'watir-webdriver'
require 'page-object'
require 'page-object/page_factory'
require 'page-object/elements'  # needed to apply the patch to remove Deprecation Warnings

require 'yaml'
require 'require_all'

require_all 'lib/pages'

#matchers
RSpec::Matchers.define :include_all do |expected|
  match do |actual|
    (expected - actual).empty?
  end

  failure_message_for_should do |actual|
    "expected #{actual.inspect} to include all #{expected}"
  end

  failure_message_for_should_not do |actual|
    "expected #{actual.inspect} not to include all #{expected}"
  end
end

# Get rid of output
# adapted from http://stackoverflow.com/questions/4459330/how-do-i-temporarily-redirect-stderr-in-ruby
def silence_streams(*streams)
  on_hold = streams.collect { |stream| stream.dup }
  streams.each do |stream|
    stream.reopen(os_mac? ? '/dev/null' : 'NUL:')
    stream.sync = true
  end
  yield
ensure
  streams.each_with_index do |stream, i|
    stream.reopen(on_hold[i])
  end
end

module Sapphire
  #uses global variable $browser
  def start_browser(how=:reuse)
    if (how == :restart) || (how == :force_restart)
      close_browser
      puts "WARNING: Forcing browser restart" if how == :force_restart
    elsif how == :reuse
      return $browser if $browser
    end
    $wap_server = $testbed.get_wap_server
    @client = $testbed.get_client
    $browser_type = @client['browser'].to_sym
    $browser_size = @client['size']
    $browser_position = @client['position'] || [0, 0]

    #    silence_streams(STDOUT, STDERR) do
    begin
      case $browser_type
      when :ff
        profile = Selenium::WebDriver::Firefox::Profile.new #('C:\\Documents and Settings\\Administrator\\Application Data\\Mozilla\\Firefox\\Profiles\\sapphire')
        profile.native_events = false
        #profile.native_events = true
        #TODO: set native events to true, to really emulate user actions.
        # (so there will be nothing like clicking some button which is behind another object)
        # need to cleanup every test case after this
        client = Selenium::WebDriver::Remote::Http::Default.new
        client.timeout = 20 # seconds ÃƒÆ’Ã‚Â¯Ãƒâ€šÃ‚Â¿Ãƒâ€šÃ‚Â½ default is 60 - lowered to accelerate workaround on timeout issues on FF>30
        $browser = Watir::Browser.new :firefox, :http_client => client, :profile => profile
      when :ie10, :ie9
        extend_path
        #$browser = Watir::Browser.new :ie
        caps = Selenium::WebDriver::Remote::Capabilities.ie
        caps['requireWindowFocus'] = true
        caps['ie.ensureCleanSession'] = true
        $browser = Watir::Browser.new :ie, :desired_capabilities => caps
      when :gc
        extend_path
        $browser = Watir::Browser.new :chrome, :switches => %w[--lang=en_US]
        #d = Selenium::WebDriver.for :chrome, native_events: true
        #$browser = Watir::Browser.new d
        windows_set_mouse_pos(10,10)
      when :safari
        $browser = Watir::Browser.new :safari, :timeout=>180
        sleep 2
      when :remote_ff
        caps = Selenium::WebDriver::Remote::Capabilities.firefox
        #caps.native_events = false
        $browser = Watir::Browser.new :remote, :url => @client['remote_server'], :desired_capabilities => caps
      when :remote_ie
        caps = Selenium::WebDriver::Remote::Capabilities.ie
        $browser = Watir::Browser.new :remote, :url => @client['remote_server'], :desired_capabilities => caps
      when :remote_gc
        caps = Selenium::WebDriver::Remote::Capabilities.chrome
        $browser = Watir::Browser.new :remote, :url => @client['remote_server'], :desired_capabilities => caps
      when :remote_safari
        caps = Selenium::WebDriver::Remote::Capabilities.safari
        $browser = Watir::Browser.new :remote, :url => @client['remote_server'], :desired_capabilities => caps
      else
        raise "Browser type not recognized: #{$browser_type}"
      end
      Watir::always_locate = true
    rescue Exception => e
      puts "DEBUG: Backtrace contains rbuf? #{ e.backtrace =~ /rbuf/ }" if $SAPPHIRE_DEBUG
      puts "DEBUG: Message contains Safari? #{ e.message =~ /Safari/ }" if $SAPPHIRE_DEBUG
      puts e.message
      puts e.backtrace.join("\n")
      if e.message =~ /Browser type not recognized/
        abort
      elsif e.backtrace.join =~ /rbuf/
        kill_ie
      elsif e.message =~ /Safari/
        kill_safari
      end
    end
    #    end # silence stream
    raise "Could not open the browser" unless $browser
    resize_browser_to_default
    $browser
  end

  def resize_browser_to_default
    if $browser_size
      $browser.resize *$browser_size *$browser_position
    else
      $browser.maximize
    end
  end

  def close_browser
    if $browser
      begin
        $browser.close
        Watir::Wait.while { $browser.exists? }
      rescue Exception => e
        puts "WARNING: error in closing the browser"
        puts e.backtrace.join("\n")
      end
      kill_safari if $browser_type == :safari
      kill_ie if $browser_type == :ie10
      $browser = nil
    end
  end

  def browser_alive?
    begin
      $browser.title
    rescue
      return false
    end
    return true
  end

#  def take_screenshot_for(testcase)
#    p "inside sapphire"
#    if ENV["TESTBED"]
#      tb = ENV["TESTBED"].gsub('\\','/').split('/').last.split('.').first.upcase
#    else
#      tb = "Sanity"
#    end
#    if testcase.respond_to? :full_description
#      #RSpec
#      description = testcase.full_description.gsub(',','')
#    else
#      #Cucumber
#      description = testcase.title
#    end
#    title="#{tb}_#{ENV["LOAD_USER"]}_#{$browser_type.upcase}_#{description}"
#    if $browser.driver.respond_to? :save_screenshot
#      puts "#{Time.now} Taking screenshot for '#{title}'"
#      begin
#        puts "screenshot"
#        $browser.driver.save_screenshot "screenshots/#{title}.png"
#      rescue Timeout::Error => e
#        puts "WARNING: Screenshot failed"
#        puts e.backtrace.join("\n")
#      end
#    else
#      puts "#{Time.now} Screenshot not supported at '#{title}'"
#    end
#    #embedding
#    if testcase.respond_to? :execution_result
#      #RSpec
#      testcase.execution_result[:screenshot_path] = "screenshots/#{title}.png"
#    else
#      #Cucumber
#      embed("screenshots/#{title}.png", "image/png")
#    end
#  end

  def monitor_IE_size_and_restart_if_necessary
    return unless ($browser_type == :ie9) || ($browser_type == :ie10)
    ie_task_list = `tasklist /FI "IMAGENAME eq iexplore.exe" /FI "MEMUSAGE gt 1500000" /FO CSV`.split("\n")
    if ie_task_list.size > 1
      puts "WARNING: Restarting IE as it occupies more than 1.5GB of RAM"
      @browser = start_browser :restart
    end
  end

  def kill_ie
    return unless ($browser_type == :ie9) || ($browser_type == :ie10)
    sleep 2
    ["iexplore.exe", "IEDriverServer.exe", "WerFault.exe"].each do |process|
      break if `tasklist /FI "IMAGENAME eq #{process}" /FO CSV`.split("\n").size <= 1
      puts "WARNING: Killing instances of #{process}"
      `taskkill /F /T /IM #{process}`
    end
  end

  def kill_safari
    return unless $browser_type == :safari
    sleep 5
    puts "WARNING: Killing instances of Safari, if present"
    `killall Safari`

    sleep 2
    puts "WARNING: Removing leftover Extensions and Estensions.bak, if present"
    e = Selenium::WebDriver::Safari::Extension.new
    e.install_directory.rmtree if e.install_directory.exist?
    if e.backup_directory.exist?
      FileUtils.mv e.backup_directory.to_s, e.install_directory.to_s
    end
  end

  def os_mac?
    RUBY_PLATFORM =~ /darwin/
  end

  def windows_set_mouse_pos(x,y)
    return if os_mac?
    require 'Win32API'
    setCursorPos = Win32API.new("user32", "SetCursorPos", ['I','I'], 'V')
    setCursorPos.Call(x,y)
  end

  def extend_path
    #add current directory to executable path, to allow distributing IE and GC drivers
    pwd = Dir.pwd
    path = ENV["PATH"]
    return if path.include? pwd
    ENV["PATH"] = "#{pwd}#{os_mac?.nil? ? ";" : ":"}#{path}"
  end

  def enable_local_smart_services
    begin
      $browser.goto $browser.url.gsub /#/, "?localdata=true#"
      on AppPage
    end unless $browser.url =~ /localdata/
  end

  # use instance variable @browser
  def logged_in?
    return false unless browser_alive?
    3.times do
      begin
        return @browser.div(:id=>'wap-applicationShell').exists?
      rescue Selenium::WebDriver::Error::InvalidSelectorError => ise
        puts "WARNING: found Selenium::WebDriver::Error::InvalidSelectorError, now sleeping 2s..."
        puts ise.message
        sleep 2
      end
    end
  end

  def as_user(user)
    begin
      logout
      login_to_wap_as user
    end unless current_user_is user
  end

  def login_to_wap_as(user = :admin)
    $app_url = $wap_server['application_url']
    visit LoginPage do |page|
      page.login_with credentials_for user
    end
    Watir::Wait.until { logged_in? }
    #on AppPage
    on(AppPage).dismiss_startup_dialog_if_present
  end

  def credentials_for(user)
    i = ENV["LOAD_USER"]
    if i
      case
      when user==:admin
        return "adminauto#{i}", "adminauto#{i}"
      when user==:demo
        return "demoauto#{i}", "demoauto#{i}"
      when user==:operator
        return "operatorauto#{i}", "operatorauto#{i}"
      else
        raise "Unknown user: #{user}"
      end
    else
      case
      when user==:admin
        return $wap_server['admin_user_name'], $wap_server['admin_password']
      when user==:demo
        return $wap_server['demo_user_name'], $wap_server['demo_password']
      when user==:operator
        return $wap_server['operator_user_name'], $wap_server['operator_password']
      else
        raise "Unknown user: #{user}"
      end
    end
  end

  def current_user_is(user)
    on(AppPage).current_user == credentials_for(user).first
  end

  def logout
    on(AppPage).logout
    on(LoginPage)
  end

  def in_window(locator, &block)
    current_parent = @browser.window
    new_window = @browser.window(locator)
    begin
      sleep 2 if ($browser_type == :safari) || ($browser_type == :gc) #unblocks Safari and GC on Mac
      new_window.wait_until_present
      new_window.use do
        yield new_window, block if block_given?
      end
      new_window.close
    rescue Watir::Exception::NoMatchingWindowFoundException, Selenium::WebDriver::Error::ScriptTimeOutError => e
      windows = @browser.windows
      puts "WARNING: WINDOW NOT FOUND #{e.inspect} AMONG ALL WINDOWS: #{windows.collect {|w| w.title}}"
      windows.last.close unless windows.last == current_parent
      raise e
    rescue Exception => e
      puts "WARNING: EXCEPTION IN IN_WINDOW #{e.inspect}"
      new_window.close
      raise e
    end
  end

  def use_device(device_id)
    device = $testbed.get_device(device_id)
    #previous_page = @current_page
    visit(DeviceWorkCenterPage) do |page|
      page.add_device(device) unless page.device_exists?(device["ipaddr"])
    end
    device
    #visit previous_page
  end

  def unique(id)
    time = Time.new
    time.strftime("#{id}_%y%m%d%H%M%S")
  end

  def short_unique(id)
    time = Time.new
    time.strftime("#{id}%6N")
  end

=begin
  def wap_ready?
    @browser.execute_script "
      return wap.getEventManager() != null"
  end

  def init_wap_checker
    @browser.execute_script "
      if (wap.getEventManager() == null) return false;
      window.page_opened = null;
      var _pageHandle = wap.getEventManager().subscribe(
        'PAGE_EVENT_TOPIC',
        null,
        function(event){
          if(event.eventType === 'PAGE_OPENED'){
            //window.alert('page loaded!')
            // Do something.
            window.page_opened = true;
            for (i=1;i<5*100000000;i++) {}
          }else if(event.eventType === 'PAGE_CLOSING'){
            // Do something on close of the page
            window.page_opened = false;
          }
        },
        null);
      return true;"
  end

  def page_opened?
    @browser.execute_script "return window.page_opened;"
  end
=end

end #module Sapphire

#monkey patches

module Enumerable
  def visible_only
    self.select{|item| item.visible?}
  end
end

module Watir
  class Browser
    def resize(width, height, x=0, y=0)
      self.driver.manage.window.resize_to(width, height)
      self.driver.manage.window.move_to(x, y)
    end

    def maximize
      #screen_width = self.execute_script("return screen.width;")
      #screen_height = self.execute_script("return screen.height;")
      #resize(screen_width, screen_height)
      self.window.maximize
    end
  end

  class Element
    #
    # hover the element
    #
    def hover
      puts "get into hover function"
      case $browser_type
      when :safari, :ff # we use FF without native events
        fire_event('mouseover')
      else #:gc, :ie
        native_hover
      end
    end

    #
    # hover the element using native event, as defined in watir-webriver
    #
    def native_hover
      # original watir-webdriver code for hover
      assert_exists
      assert_has_input_devices_for :hover

      driver.action.move_to(@element).perform
    end

    def to_page_object_element
      PageObject::Elements::Div.new(self, :platform => :watir_webdriver)
    end
  end
end

module PageObject
  module Elements
    class Element
      #
      # double_click the element
      #
      def double_click
        if $browser_type == :safari
          element.fire_event('dblclick')
        else
          element.double_click
        end
      end

      #
      # element is present?
      #
      def present?
        begin
          element.present?
        rescue Selenium::WebDriver::Error::InvalidSelectorError, Timeout::Error => e
          puts "WARNING: Caught #{e.message}..  retrying after 5s"
          sleep 5
          element.present?
        end
      end

      #
      # redefine class_name that was deprecated
      #
      def class_name
        element.attribute_value "class"
      end

      #
      # redefine tr that was deprecated
      #
      def tr(*args, &block)
        element.tr(*args, &block)
      end

      #
      # redefine td that was deprecated
      #
      def td(*args, &block)
        element.td(*args, &block)
      end

      #
      # redefine title that was deprecated
      #
      def title(*args, &block)
        element.title(*args, &block)
      end

      #
      # remove deprecation warning
      #
      def method_missing(*args, &block)
        m = args.shift
        $stderr.puts "        *** Deprecated #{m} at #{caller[0]}."
        # $stderr.puts "*** DEPRECATION WARNING"
        # $stderr.puts "*** You are calling a method named #{m} at #{caller[0]}."
        # $stderr.puts "*** This method does not exist in page-object so it is being passed to the driver."
        # $stderr.puts "*** This feature will be removed in the near future."
        # $stderr.puts "*** Please change your code to call the correct page-object method."
        # $stderr.puts "*** If you are using functionality that does not exist in page-object please request it be added."
        begin
          element.send m, *args, &block
        rescue Exception => e
          raise
        end
      end
    end
  end
end

