require 'spec_helper'

describe "Prime Insight Device Reports" do

  before :all do
    visit DeviceReportsPage
  end

  #  it "Verify Globaladmin User can scheduled the report from If Util - from Chart::Tny1889069c" do
  #
  #    on DeviceReportsPage do |page|
  #
  #      page.device_report("All=>Cisco Catalyst 3750 Series Switches")
  #      # Columns Settings
  ##      page.deviceReports_element.wd.location_once_scrolled_into_view
  ##      device=page.deviceReports_element
  ##      page.headers_of(device).should include "Device Name", "Device Type", "Device IP", "Serial Number", "Software Version", "Number Of Chassis", "Number Of Modules"
  ##      page.toggle_visibility_for_column(device, "Device Name")
  ##      page.headers_of(device).should include "Device Type", "Device IP", "Serial Number", "Software Version", "Number Of Chassis", "Number Of Modules"
  #      # Columns Sorting
  ##      page.toggle_visibility_for_column(device, "Device Name")
  ##      rows=page.rows_of(device)
  ##      rows[0].text.should include "prime-asr9k-cluster", "Cisco ASR 9006 Router", "172.23.222.223", "FOX1316GFA1, FOX1318G5WJ", "5.1.1[Default]", "2", "35"
  ##      rows[1].text.should include "Satellite 101 : 172.23.222.223","Cisco ASR 9006 Router", "3.3.4.101", "CAT1802U1QD", "322.6", "NA", "NA"
  ##      page.sort_by_column(device, "Device IP")
  ##      rows=page.rows_of(device)
  ##      rows[0].text.should include "prime-asr9k-cluster", "Cisco ASR 9006 Router", "172.23.222.223", "FOX1316GFA1, FOX1318G5WJ", "5.1.1[Default]", "2", "35"
  ##      rows[1].text.should include "Chassis 1 : prime-asr9k-cluster", "Cisco ASR 9006 Router", "172.23.222.223", "FOX1318G5WJ", "5.1.1[Default]", "NA", "NA"
  #    end
  #  end

  it "Verify the PIE Chart::Tny34434" do

    on DeviceReportsPage do |page|
      expect(page.device_report("All")).not_to be_empty
    end

  end

end