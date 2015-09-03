require './spec/spec_helper.rb'

describe "US11074 Home Menu-InterfaceUtilizationPage" do

  before :all do
    @browser.goto ("https://#{$pc_server_ip}/emsam/applications/emsam/PIDiagnostics/ResourceUsage.jsp")
    visit ProductDiagPage
  end

  it "should be able to Verify Launch the Hidden UI::Tny1653188c" do

    on ProductDiagPage do |page|
      expect_output = 'PI Resource Monitor'
      expect(page.PageTitle).to be == expect_output
    end
  end

  it "should be able to Verify Server Disk free Information::Tny1653189c" do
    on ProductDiagPage do |page|
      expect(page.diskfreeinfo).to be_true
    end
  end

  it "should be able to Verify Refresh and back Buttons in Server Disk free Info page::Tny1653190c" do
    on ProductDiagPage do |page|
      expect(page.click_refresh).to be_true
      expect(page.click_back).to be_true
    end
  end

  it "should be able to Verify Server Memory Information::Tny1653191c" do
    on ProductDiagPage do |page|
      expect(page.memoryinfo).to be_true
    end
  end

  it "should be able to Verify Refresh and back Buttons in Server Memory Info page::Tny1653192c" do
    on ProductDiagPage do |page|
      expect(page.click_refresh).to be_true
      expect(page.click_back).to be_true
    end
  end

  it "should be able to Verify Server CPU Information::Tny1653193c" do
    on ProductDiagPage do |page|
      expect(page.cpuinfo).to be_true
    end
  end

  it "should be able to Verify Refresh and back Buttons in Server CPU Info page::Tny1653194c" do
    on ProductDiagPage do |page|
      expect(page.click_refresh).to be_true
      expect(page.click_back).to be_true
    end
  end

  it "should be able to Verify Server Disk IO Information::Tny1653195c" do
    on ProductDiagPage do |page|
      expect(page.diskioinfo).to be_true
    end
  end

  it "should be able to Verify Refresh and back Buttons in Server Disk IO Info page::Tny1653196c" do
    on ProductDiagPage do |page|
      expect(page.click_refresh).to be_true
      expect(page.click_back).to be_true
    end
  end

  it "should be able to Verify Server Process Information::Tny1653197c" do
    on ProductDiagPage do |page|
      expect(page.processinfo).to be_true
    end
  end

  it "should be able to Verify Refresh and back Buttons in Server Process Info page::Tny1653198c" do
    on ProductDiagPage do |page|
      expect(page.click_refresh).to be_true
      expect(page.click_back).to be_true
    end
  end

  it "should be able to Verify Top Processes Information::Tny1653199c" do
    on ProductDiagPage do |page|
      expect(page.topprocessinfo).to be_true
    end
  end

  it "should be able to Verify Refresh and back Buttons in Top Processes page::Tny1653200c" do
    on ProductDiagPage do |page|
      expect(page.click_refresh).to be_true
      expect(page.click_back).to be_true
    end
  end

  it "should be able to Verify Netstat Information::Tny1653201c" do
    on ProductDiagPage do |page|
      expect(page.netstatinfo).to be_true
    end
  end

  it "should be able to Verify Refresh and back Buttons in Netstat Info page::Tny1653202c" do
    on ProductDiagPage do |page|
      expect(page.click_refresh).to be_true
      expect(page.click_back).to be_true
    end
  end

end    