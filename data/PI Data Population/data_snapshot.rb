require "Time"
require "pg"
require "csv"
require 'net/sftp'
require 'net/ssh'

@hostname = "172.20.115.141"
@username = "root"
@password = "poPPee!23"
@disable_firewall_cmd = "service iptables stop"
support_files_dir = "support files/"
data_templates_dir = "data templates/"
 
base_date = Date.new(2015, 8, 26)
final_date = Date.new(2015, 8, 28)

DAYS_OF_DATA = (final_date - base_date).to_i

factdate_hash = {
				  "alarm_fact_h_ib" => "alarmcreationdate",
				  "alarm_fact_ib" => "alarmcreationdate",
				  "device_fact_ib" => "deployed_day_end_date",
				  "event_fact_h_ib" => "notificationdate",
				  "event_fact_ib" => "notificationdate",
				  "if_utilization_fact_ib" => "date",
				  "qos_stats_fact_ib" => "date",
				  "syslog_fact_h_ib" => "syslogdate",
				  "syslog_fact_ib" => "syslogdate"
				}

ib_tables_query = "COPY(SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_name ~ '_ib') to '/var/lib/pgsql/ib_tables.txt';"
support_query = "COPY(SELECT * FROM REPLACE) To '/var/lib/pgsql/REPLACE.csv' DELIMITER '|';"
fact_query = "COPY(SELECT * FROM REPLACE WHERE DATE) To '/var/lib/pgsql/REPLACE.csv' DELIMITER '|' CSV HEADER;"
query = ""
puts "stage 1"
begin
  puts "test 1"
  ssh_session = Net::SSH.start(@hostname, @username, :password => @password)
  puts "test 2"
rescue
  puts "rescue me"
  text = File.read("C:/Users/sarunkum/.ssh/known_hosts")
  final_text = text.gsub(/#{@hostname}.*/, "")
  File.open("C:/Users/sarunkum/.ssh/known_hosts", "w"){|file| file.puts final_text}
  retry
end
puts "stage 2"
# After connecting to server under test, disable firewalls
ssh_session.exec!(@disable_firewall_cmd)


# Get list of tables in pcwh DB
conn = PG.connect(:host => @hostname, :port => "5432", :dbname => "pcwh", :user => "pcwhuser", :password => "pcwhuser")
conn.exec(ib_tables_query)
puts "stage 3"
# Download the list locally
begin
  sftp_session = Net::SFTP.start(@hostname, @username, :password => @password)
rescue
  text = File.read("C:/Users/sarunkum/.ssh/known_hosts")
  final_text = text.gsub(/#{@hostname}.*/, "")
  File.open("C:/Users/sarunkum/.ssh/known_hosts", "w"){|file| file.puts final_text}
  retry
end
sftp_session.download!("/var/lib/pgsql/ib_tables.txt", "#{support_files_dir}/ib_tables.txt")
puts "stage 4"
File.open("support files/ib_tables.txt").each do |table|
  table = table.chomp
  if table.include? "_fact_"
    for i in 0...DAYS_OF_DATA
      fact_date_query = fact_query.sub(/DATE/, factdate_hash[table] + "='" + (base_date + i).to_s + "'")
	  query = fact_date_query.gsub(/REPLACE/, table)
	  conn.exec(query)
	  puts query
	  sftp_session.download!("/var/lib/pgsql/#{table}.csv", "#{data_templates_dir}/ds#{i+1}_#{table}.csv")
	end
  else
    query = support_query.gsub(/REPLACE/, table)
	conn.exec(query)
	sftp_session.download!("/var/lib/pgsql/#{table}.csv", "#{support_files_dir}/#{table}.csv")
  end
end
puts "stage 5"