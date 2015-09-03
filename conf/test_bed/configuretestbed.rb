file_name = 'C:\Insight 1.0\Prime_Insight 1.0\conf\test_bed\pi_auto_prop.yml'

ipaddress = ARGV[0]
login = ARGV[1]
password = ARGV[2]
branch = ARGV[3]
build_number = ARGV[4]
build = ARGV[5]
browserType = ARGV[6]

text = File.read(file_name)
text = text.gsub(/server_ip:.*/, "server_ip: #{ipaddress}")
text = text.gsub(/app_username:.*/, "app_username: #{login}")
text = text.gsub(/app_password:.*/, "app_password: #{password}")
text = text.gsub(/branch:.*/, "branch: #{branch}")
text = text.gsub(/build_number:.*/, "build_number: #{build_number}")
text = text.gsub(/browserType:.*/, "browserType: #{browserType}")
final_text = text.gsub(/build:.*/, "build: #{build}")

File.open(file_name, "w") {|file| file.puts final_text}

puts final_text