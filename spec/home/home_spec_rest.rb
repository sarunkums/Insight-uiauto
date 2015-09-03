require 'spec_helper.rb'

before :all do
  duration_filter = {"7 Days" => "7d", "2 Weeks" => "2w", "4 Weeks" => "4w", "12 Weeks" => "12w", 
                     "24 Weeks" => "24w", "52 Weeks" => "52w", "56 Weeks" => "56w", "12 Months" => "12m", 
                     "13 Months" => "13m"}
  location_filter = {"All" => "All", "San Jose" => "Location/All Locations/San Jose", "India" => "Location/All Locations/India"}
  interface_group_filter = {"All" => "All"}
  qos_classmap_filter = {}
end

describe "Interface Utilization Data Table" do
  it "should display correct values for 7 days of data, all locations, all interfaces"
  it "should display correct values for 2 weeks of data, all locations, all interfaces"
  it "should display correct values for 4 weeks of data, all locations, all interfaces"
  it "should display correct values for 4 weeks of data, San Jose location, all interfaces"
  it "should display correct values for 4 weeks of data, India location, all interfaces"
end

describe "Top N Utilized Interfaces" do
  
end

describe "Errors and Discards Data Table" do
  
end

describe "QoS Classes Data Table" do
  
end