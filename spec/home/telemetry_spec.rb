require './spec/spec_helper.rb'

describe "US12883, US12881, US12041 -  Telemetry" do

  before :all do
    on TelemetryPage do |page|
      page.globaladmin_element.flash.click
      page.helpus_element.flash.click
    end
  end

  it "should be verify Telemetry popup::Tny1654723c" do
    on TelemetryPage do |page|
      sleep 3
      page.telemetrydialog_element.flash
      page.telemetrydialog_element.should be_present
    end
  end

  it "should be verify Telemetry default check box::Tny1654724c" do
    on TelemetryPage do |page|
      expect(page.yescheck_element.set?).to be_true
      page.defaultchk.should be == "Status : Enabled"
    end
  end

  it "should be verify Telemetry sample data::Tny1654725c" do
    on TelemetryPage do |page|
      expect_output= ['System Information','Browser Information','Schedule Report Information']
      expect(page.connect_info).to be == expect_output
    end
  end

  it "should be verify Telemetry UI-action taken on yes check box selection::Tny1654726c" do
    on TelemetryPage do |page|
      expect_output='Status : Enabled'
      expect(page.chk_enabled).to be == expect_output
    end
  end
end  