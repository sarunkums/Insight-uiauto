require "Time"
require "pg"
require "csv"
require 'net/sftp'
require 'net/ssh'

@hostname = "172.20.115.107"
@username = "root"
@password = "Cpcm123$"
@disable_firewall_cmd = "service iptables stop"

fact_key = 0
DAYS_OF_DATA = 14
DATA_SETS = 2
data_set = 1

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

factkey_hash = {
				  "alarm_fact_ib" => "alarm_key",
				  "device_fact_ib" => "device_key",
				  "event_fact_ib" => "event_key",
				  "if_utilization_fact_ib" => "if_utilization_key",
				  "qos_stats_fact_ib" => "qos_stats_key",
				  "syslog_fact_ib" => "syslog_key"				 
			   }
				
date_table_query = "COPY(SELECT * FROM date_dimension) To '/var/lib/pgsql/date_dimension_ib.csv' With CSV HEADER;"
truncate_cmd = "TRUNCATE "
support_files = []
data_files =[]

# Generate truncate_cmd string, data_files array, and support_files array listing
File.open("support files/ib_tables.txt").each do |table|
  table = table.chomp
  truncate_cmd = truncate_cmd + table + ", "
  if table.include? "_fact_"
    data_files.push(table)
  elsif table.include? "date_dimension_ib"
    x = 0
  else
	  support_files.push(table)
    truncate_cmd = truncate_cmd + table.gsub(/_ib/,"") + ", "
  end
  puts truncate_cmd
  sleep 3
end
puts truncate_cmd = truncate_cmd.slice(0...-2)

begin
  ssh_session = Net::SSH.start(@hostname, @username, :password => @password)
rescue
  text = File.read("C:/Users/sarunkum/.ssh/known_hosts")
  final_text = text.gsub(/#{@hostname}.*/, "")
  File.open("C:/Users/sarunkum/.ssh/known_hosts", "w"){|file| file.puts final_text}
  retry
end

# After connecting to server under test, disable firewalls
ssh_session.exec!(@disable_firewall_cmd)

# Connect to server under test with pg ruby library for postgresql queries, query for the date table, and store the resulting CSV local to the server
conn = PG.connect(:host => @hostname, :port => "5432", :dbname => "pcwh", :user => "pcwhuser", :password => "pcwhuser")
conn.exec(date_table_query)

# delete existing server data
conn.exec(truncate_cmd)

# Open sftp session and extract date file to local machine
sftp_session = Net::SFTP.start(@hostname, @username, :password => @password)
sftp_session.download!("/var/lib/pgsql/date_dimension_ib.csv", "support files/date_dimension_ib.csv")

# Open base CSV files and read in data
date_dimension_csv = CSV.read('support files/date_dimension_ib.csv', headers:true)

# Populate base files from local machine to insight server
for file_index in (0...support_files.size)
  table_name = support_files[file_index].sub /.csv/, ''
  puts "Insert #{support_files[file_index]} into #{table_name}...\n"
  sftp_session.upload!("support files/#{support_files[file_index]}.csv", "/opt/emms/emsam/advance_reporting/bin/#{support_files[file_index]}.csv")
  puts ssh_session.exec!("cd /opt/emms/emsam/advance_reporting/bin\n./dlpcsvloader.sh #{support_files[file_index]}.csv #{table_name}")
end


for day_generated in (0...DAYS_OF_DATA)
  
  if data_set > DATA_SETS
    data_set = 1;
  end
  
  # Find desired date
  date_field = Date.today - (DAYS_OF_DATA - day_generated)
  puts "\n\ndate_field: " + date_field.to_s + "\n\n"

  # Find the row of the first date of data, then populate into table
  date_dimension_csv.each do |date_dim_row|
    if date_dim_row['day_end_date'] == date_field.to_s
      puts "Row is found"
	  fact_key = 0
	  for fact_files in 0...data_files.length
	    fact_csv = CSV.read("data templates/ds#{data_set}_#{data_files[fact_files]}.csv", col_sep: '|', headers:true)
	    fact_csv.each do |fact_row|
	      fact_key += 1
	      fact_row[factkey_hash[data_files[fact_files]]] = fact_key
	      fact_row[factdate_hash[data_files[fact_files]]] = date_field.to_s
	      fact_row['day_in_month'] = date_dim_row['day_in_month']
	      fact_row['month_number'] = date_dim_row['month_number']
	      fact_row['quarter_number'] = date_dim_row['quarter_number']
	      fact_row['year'] = date_dim_row['year']
	      fact_row['week_number'] = date_dim_row['week_number']
	      fact_row['year_for_week'] = date_dim_row['year_for_week']
	    end
		# Iterate through date row
        puts "Generating Day #{day_generated + 1} #{data_files[fact_files]} data\n"
        CSV.open("generated data/day#{day_generated + 1}_#{data_files[fact_files]}.csv", 'w', col_sep: '|') do |new_fact|
          fact_csv.each do |row|
            new_fact << row
          end
        end
		puts "#{data_files[fact_files]} data successfully created\n"
        # Transfer data to server under test
        sftp_session.upload!("generated data/day#{day_generated + 1}_#{data_files[fact_files]}.csv", "/opt/emms/emsam/advance_reporting/bin/day#{day_generated + 1}_#{data_files[fact_files]}.csv")
		puts "Uploading generated data/day#{day_generated + 1}_#{data_files[fact_files]}.csv to /opt/emms/emsam/advance_reporting/bin/day#{day_generated + 1}_#{data_files[fact_files]}.csv"
        # Insert data into table
        ssh_session.exec!("cd /opt/emms/emsam/advance_reporting/bin\n./dlpcsvloader.sh day#{day_generated + 1}_#{data_files[fact_files]}.csv #{data_files[fact_files]}")
		puts "executed dlpcsvloader.sh day#{day_generated + 1}_#{data_files[fact_files]}.csv #{data_files[fact_files]}"
	  end
    end
  end
  data_set += 1
end 

system("wget --no-check-certificate --no-proxy --read-timeout=0 -t 3 -w 40m -q -O - https://#{@hostname}/emsam/service/advrep/mondrian/refreshCache")

