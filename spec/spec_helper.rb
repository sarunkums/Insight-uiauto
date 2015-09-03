$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), ',,', 'lib'))

require 'rspec'
require 'rspec/expectations'
require 'yaml'
require 'watir-webdriver'
require 'page-object'
require 'page-object/page_factory'
require 'require_all'
require 'net/ssh'
require 'net/ssh/telnet'
require 'matches'
require 'snmp'
require 'rest-client'
require 'rbvmomi'
require 'watir-webdriver/wait'
require 'data_magic'
require 'pdf-reader'
require 'nokogiri'
require 'net/scp'
require 'json'
require 'log4r'
require 'logger'
require 'ostruct'
require 'pg'
require 'common/sapphire'
require 'watir-scroll'

#require_all 'spec/nbi/model'
#require_all 'spec/nbi/helpers'

require_all 'lib/pages'
#require_all 'lib/widgets'
#require_all 'lib/commons'

class Testbed
  @@testbed = {}

  TESTBED_NOT_DEFINED = "TESTBED environment variable not found. Hence using default file pi_auto_prop.yml"

  def initialize
    filename = ENV["TESTBED"]
    if ! filename then
      p TESTBED_NOT_DEFINED
      filename = "conf/test_bed/pi_auto_prop.yml"
    end
    @@testbed = YAML.load_file filename
    #@@testbed = YAML::load(File.open("conf/testbed/pc_auto_prop.yml"))
  end

  def get_pc_server
    @@testbed['pc_system_details'][0]
  end

  def get_timeout
    @@testbed['timeout_details'][0]
  end

end

RSpec.configure do |config|
  ENV['REPORT_PATH']='C:/inetpub/wwwroot/reports/Serpent'
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.include Sapphire
  config.include PageObject::PageFactory
  $provisioning_output="output/provisioning"
  $batchFile_path="data/Provision_Management/OrderManagement/batch"
  $assurance_output="output/assurance"
  $DEVICE_360_PATH="lib/pages/operate/device360"
  $output_file="result.html"
  $target_phone=''
  $selected_phone=''
  $exception_counter=0
  $em_access_name=''
  #$devicepool_data=CSV.read("data/DevicePool.csv")
  #$aaaServer_data=CSV.read("data/aaaServer/AAAServer.csv")
  $aaaServerHash=Hash.new
  $domStatus=false
  $rtmt_output="data/rtmt"
  $device360_output="data/device360"
  $fault_output="data/faults"
  $rtmt_response_path="data/rtmt/responseFiles/"
  $serviceAreaStatus=false
  $CUSTOMER_NAME=''
  $load_subscriber_details=Hash.new

  ### Tritron Specific variables::Start
  $dataPathMediaSense="data/rtmt/mediaSense"
  $dataPathFinesse="data/rtmt/finesse"
  $dataPathCUIC="data/rtmt/cuic"
  $dataPathSocialMiner="data/rtmt/socialMiner"
  $dataPathCVP="data/rtmt/cvp"
  ####Tritron Specific variables::End
  time = Time.new
  $curr_time=time.strftime("%Y-%b-%d")

  $dash_name="Dash-#{Time.now}"

  p "current date is :: #{$curr_time}"
  config.after :each do |after_config|
    #    puts "get into take screen shot"
    if example.exception
      puts "Taking screenshot for " + example.full_description
      tc_name=example.full_description.gsub(":","_")
      tc_name=tc_name.gsub("-","_")
      length=example.full_description.length
      p "Total length of the screenshot name is #{length}"
      finaltime=time.hour.to_s+time.min.to_s+time.sec.to_s
      if length>255
        tc_name=finaltime
      end
      @browser.driver.save_screenshot('screenshots/' + tc_name + '.png')
      puts "..taken"
    end
  end

  #  config.after(:all) do
  #    system("ruby spec/results_utility.rb")
  #  end

  config.before(:all) do
    $pm_report=''
    $testbed = Testbed.new()
    #$pm_server = $testbed.get_pm_server
    # $pm_server_ip = $pm_server['server_ip']
    #set environment variable to store reports
    ENV['CI_REPORTS'] = "reports"
    puts "Reports will be stored under :: #{ENV['CI_REPORTS']}"
    @pc_server = $testbed.get_pc_server
    # @selfcare_server=$testbed.get_selfcare_server
    @timeout = $testbed.get_timeout
    #    @port = @pc_server['port']
    @proxy = @pc_server['proxy']
    @sshPort = @pc_server['sshPort']
    $sshPort = @pc_server['sshPort']
    mode = @pc_server['mode']
    upgraded = @pc_server['upgraded']
    $pc_server_ip = @pc_server['server_ip']
    $pc_user = @pc_server['app_username']
    $pc_pwd = @pc_server['app_password']
    $systemuser = @pc_server['systemuser']
    $systempwd = @pc_server['systempwd']

    $isMSP = false
    if mode.eql?"msp" then
      p "SPEC_HELPER : Mode is MSP"
      $isMSP = true
    end

    $isUpgraded = false
    if upgraded.eql?"yes" then
      p "SPEC_HELPER : System has been upgraded!"
      $isUpgraded = true
    end

    @emsam_cred_file = 'data/emsam_credentials_lab.xml'
    #constants = PrimeCollabConstants.new
    if ENV['BROWSER_TYPE']
      p 'Picking the values from the ENV variable'
      @browserType = ENV['BROWSER_TYPE']
    else
      p 'Reading browserType from the pc_auto_prop.yml file'
      @browserType = @pc_server['browserType']
    end
    @short_timeout = @timeout['short_time']
    @long_timeout = @timeout['long_time']
    ### These parameters are used to add firebug and max script execution values to profile.
    @script_maxTime=@pc_server['scriptMaxTime']
    @firebugExtn=@pc_server['firebugExtn']
    puts "pc_server",  @pc_server['server_ip']
    #    puts "port" , "#{@port}"
    #    $url = "http://"<<@pc_server['server_ip']<<":"<<"#{@port}"
    $url = "https://"<<@pc_server['server_ip']<<"/emsam/index.html"
    puts $url

    #$selfcare_url="http://"<<@selfcare_server['server_ip']<<"/cupm/selfcareuser/Login"
    puts "Running on the server with url :: " + $url

    profile = Selenium::WebDriver::Firefox::Profile.new
    p "Proxy is set to :: #{@proxy}"
    if @proxy
      profile.proxy = Selenium::WebDriver::Proxy.new(
      :http => @proxy,
      :ssl  => @proxy,
      :ftp  => @proxy,
      :no_proxy => 'localhost,10.0.0.0/8,cisco.com')
    end
    profile['dom.max_script_run_time']=@script_maxTime
    profile['dom.max_chrome_script_run_time']=0
    profile['network.proxy.type'] = 0   # Here i was set no proxy
    profile.native_events = false
    #download directory
    $download_directory = "#{Dir.pwd}/downloads"
    p "Download directory :: #{$download_directory}"
    $download_directory.gsub!("/", "\\") if Selenium::WebDriver::Platform.windows?
    # $csv_file = Dir.entries($download_directory).reject{|f|File.ftype(f)!='file'}.sort_by{|f| File.ctime(f)}.last
    # $last_csv_file = get_last_created($download_directory)
    #$acctno = "Top_N_Conference_Locations"
    #File.rename(f, "#{$acctno}.csv") if Time.now-File.ctime(f)<2
    p "Download directory after converting to windows path :: #{$download_directory}"
    profile['browser.download.folderList'] = 2 # custom location
    profile['browser.download.lastDir'] = $download_directory
    profile['browser.download.dir'] = $download_directory
    profile['browser.download.manager.showWhenStarting'] = false
    profile['browser.helperApps.alwaysAsk.force'] = false
    profile['pdfjs.disabled'] = true
    profile['browser.helperApps.neverAsk.saveToDisk'] = "text/csv,text/plain,application/csv,text/comma-seperated-values,application/octet-stream,text/pdf,application/pdf"
    profile['browser.download.manager.closeWhenDone'] = true
    #profile.add_extension("thirdparty/firebug.xpi")                                               #to be uncommented when to debug while execution

    # GRID shell variable to contain URL :: "http://10.64.101.85:4444/wd/hub"
    if ENV['GRID']
      p 'Grid Mode'
      @browser = Watir::Browser.new :remote,:url =>ENV['GRID'], :desired_capabilities => :firefox#, :profile => profile
    else
      p "#{@browserType} is selected"
      if @browserType == "ie"
        $browser_type = :ie10
        @browser = Watir::Browser.new 'ie'
      elsif @browserType == 'chrome'
        $browser_type = :gc
        @browser = Watir::Browser.new :chrome
      else
        $browser_type = :ff
        @browser = Watir::Browser.new @browserType, :profile => profile
      end

    end
    #Close a specific tab
    #@browser.window(:title => "Firebug").when_present(30).use do
    #@browser.button(:id => "close").when_present(30).click
    #end
    ##code to maximize the browser test window::Start

    width = @browser.execute_script("return screen.width;")
    height = @browser.execute_script("return screen.height;")
    @browser.driver.manage.window.move_to(0,0)
    @browser.driver.manage.window.resize_to(width,height)

    ##code to maximize the browser test window::End
    on LoginPage do |page|
      puts "comes here"
      page.navigate_to $url
      if @browserType == "ie"
        p "....skipping security certificate for ie "
        @browser.goto("javascript:document.getElementById('overridelink').click()")
        p "....not stuck "
      end
      if @browser.alert.exists?
        p @browser.alert.text
        p 'accepting alert dialog temporarily'
        @browser.driver.switch_to.alert.accept
      end
      #sleep @short_timeout
      page.login_with @pc_server['app_username'], @pc_server['app_password']
      # page.refreshPage
      puts "Sleeping..."
      sleep 5
      puts "done sleep1"
    end

    on_page(AppPage) do |dashPage|
      puts "attempting to close evaluation alert"
      dashPage.evaluation_alert
      puts "finished trying to close evaluation alert"
    end

    on_page(AppPage) do |dashPage|
      dashPage.close_the_popup
    end

    #    on AppPage
    #    puts "done 3"

    #    ##This block is added to execute RTMT test cases in Standard &Advanced based on megamenu navigation
    #    p "---------------Application mode is--------------#{ENV['appMode']}"
    #    if (ENV['appMode']!=nil and ENV['appMode']=='advanced')
    #      on_page(Rtmt)do|rtmt|
    #        rtmt.navigate_application_to "Home=>Standard Dashboard"
    #        sleep 2
    #      end
    #    end
  end

    config.after(:all) do
      sleep 10
      @browser.close 
    end

end
