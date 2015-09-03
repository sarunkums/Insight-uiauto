require 'Nokogiri'
require 'net/smtp'
require 'yaml'

passed = Array.new
failed = Array.new
passed_email = Array.new
failed_email = Array.new
failed_details = Array.new
REPORTS_DIR = "reports/"
body = ""
test_type = ARGV[0]
test_params = YAML::load(File.open('c:\Insight 1.0\Prime_Insight 1.0\conf\test_bed\pi_auto_prop.yml'))
pc_server = test_params['pc_system_details'][0]
  
Dir.foreach(REPORTS_DIR) do |userstoryresultfile|
  
  next if userstoryresultfile == '.' || userstoryresultfile == '..' || userstoryresultfile == 'passed.txt' || userstoryresultfile == 'failed.txt' || userstoryresultfile == 'failedDetails.txt'
  xml_results = Nokogiri::XML(File.open(REPORTS_DIR + userstoryresultfile))
  slop_results = Nokogiri::Slop(File.open(REPORTS_DIR + userstoryresultfile))
  all_names = xml_results.xpath("//testcase/@name")
 

  all_names.each do |testcase_names|
    begin
      if (failed_result = slop_results.html.body.testsuite.testcase("[@name='#{testcase_names.to_s}']").failure.content)
        failed.push(testcase_names.to_s[/Tny(.*)c/] + "," + "FALSE" + "\n")
        failed_details.push(testcase_names.to_s[/Tny(.*)c/] + ", " + failed_result + "\n")
      end
    rescue
      passed.push(testcase_names.to_s[/Tny(.*)c/] + "," + "TRUE" + "\n")
    end
  end
  
  body << "<h3>" + userstoryresultfile + "</h3>"
    
  failed_details.each do |failed_case|
    body << failed_case + "<br><br>"
  end
  
  failed_details.clear
  
end

File.open(REPORTS_DIR + "passed.txt", "w+") do |p|
  p.puts(passed)
end

File.open(REPORTS_DIR + "failed.txt", "w+") do |f|
  f.puts(failed)
end

File.open(REPORTS_DIR + "failedDetails.txt", "w+") do |fd|
  fd.puts(failed_details)
end

email = <<MESSAGE_END
From: sarunkum@cisco.com
To: primeinsight-auto@cisco.com
MIME-Version: 1.0
Content-type: text/html
Subject: #{test_type} Test Results: bld:#{pc_server['build_number']} branch:#{pc_server['branch']} build:#{pc_server['build']} browser:#{pc_server['browserType']} 
<html><body>
server ip: #{pc_server['server_ip']}<br>
login: #{pc_server['app_username']}<br>
password: #{pc_server['app_password']}<br>

Passed: #{passed.length}<br>
Failed: #{failed.length}<br>

<h1>Failed Test Cases Details</h1>

#{body}
</body></html>
MESSAGE_END

Net::SMTP.start('outbound.cisco.com') do |smtp|
  smtp.send_message email, 'sarunkum@cisco.com', 'primeinsight-auto@cisco.com'
  #smtp.send_message email, 'sarunkum@cisco.com', 'sarunkum@cisco.com'
end