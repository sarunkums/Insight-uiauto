require "Time"
require "csv"
require "pg"
require 'net/sftp'
require 'net/ssh'
require 'yaml'

puts "change 1"
data_population = YAML::load(File.open('conf/test_bed/pi_auto_prop.yml'))
details = data_population['data_system_details'][0]  # Here i made the changes to read the input from pi_auto_prop.yml -> data_populations instated of pi_auto_prop.yml -> pc_system_details.
  
@hostname = details['server_ip']
@username = details['app_root']
@password = details['app_password']
  
puts @hostname
puts @username
puts @password
    
@disable_firewall_cmd = "service iptables stop"
data_generation_base = "data/data_generation_base/"
generated_files = "data/generated_files/"

# test comment

if_util_key = 0
qos_stats_key = 0
days_of_data = 30
data_set = 1

date_table_query = "COPY(SELECT * FROM date_dimension) To '/var/lib/pgsql/date_dimension_ib.csv' With CSV HEADER;"
truncate_cmd = "TRUNCATE devicedim_type1_ib, interface_group_bridge_ib, interface_group_dim_ib, interfacedim_type1_ib, sitegroup_bridge_ib, sitegroup_dim_ib, if_utilization_fact_ib, qos_stats_fact_ib, date_dimension_ib"
support_files = ["devicedim_type1_ib.csv", "interface_group_bridge_ib.csv", "interface_group_dim_ib.csv", "interfacedim_type1_ib.csv", "sitegroup_bridge_ib.csv", "sitegroup_dim_ib.csv", "date_dimension_ib.csv"]
disable_script = "mv /opt/emms/emsam/advance_reporting/bin/periodicTestData.sh /opt/emms/emsam/advance_reporting/bin/periodicTestDataDISABLED.sh"
  
# Connect to server under test, disable firewalls
begin
   ssh_session = Net::SSH.start(@hostname, @username, :password => @password)
rescue
  text = File.read("C:/Users/Lab/.ssh/known_hosts")
  final_text = text.gsub(/#{@hostname}.*/, "")
  File.open(ENV['USERPROFILE'] + "/.ssh/known_hosts", "w"){|file| file.puts final_text}
  retry
end
puts "here"
ssh_session.exec!(@disable_firewall_cmd)
ssh_session.exec!(disable_script)

# Connect to server under test with pg ruby library for postgresql queries, query for the date table, and store the resulting CSV local to the server
conn = PG.connect(:host => @hostname, :port => "5432", :dbname => "pcwh", :user => "pcwhuser", :password => "pcwhuser")
conn.exec(date_table_query)

# delete existing server data
conn.exec(truncate_cmd)

# code for demo
#system("wget --no-check-certificate --no-proxy --read-timeout=0 -t 3 -w 40m -q -O - https://#{@hostname}/emsam/service/advrep/mondrian/refreshCache")
#puts "\n\nInfobright tables cleared, cache refreshed, sleeping..."
#sleep 10


# Open sftp session and extract date file to local machine
sftp_session = Net::SFTP.start(@hostname, @username, :password => @password)
sftp_session.download!("/var/lib/pgsql/date_dimension_ib.csv", "#{data_generation_base}date_dimension_ib.csv")

# Open base CSV files and read in data
date_dimension_csv = CSV.read("#{data_generation_base}date_dimension_ib.csv", headers:true)

# Populate base files from local machine to insight server
for file_index in (0...support_files.size)
  table_name = support_files[file_index].sub /.csv/, ''
  puts "#{data_generation_base}#{support_files[file_index]}"
  sftp_session.upload!("#{data_generation_base}#{support_files[file_index]}", "/opt/emms/emsam/advance_reporting/bin/#{support_files[file_index]}")
  puts ssh_session.exec!("cd /opt/emms/emsam/advance_reporting/bin\n./dlpcsvloader.sh #{support_files[file_index]} #{table_name}")
end

for day_generated in (0...days_of_data)
  
  if data_set > 9
    data_set = 1
  end
  
  puts ""
  if_util_csv = CSV.read("#{data_generation_base}ds#{data_set}_if_utilization_fact_ib.csv", col_sep: '|', headers:true)
  qos_stats_csv = CSV.read("#{data_generation_base}ds#{data_set}_qos_stats_fact_ib.csv", col_sep: '|', headers:true)
  data_set += 1
  
  # Find desired date
  date_field = Date.today - (days_of_data - day_generated)
  puts "\n\ndate_field: " + date_field.to_s + "\n\n"

  # Find the row of the first date of data, then populate into table
  date_dimension_csv.each do |date_dim_row|
    if date_dim_row['day_end_date'] == date_field.to_s
      puts "Row is found"
      if_util_csv.each do |if_util_row|
        if_util_key += 1
        if_util_row['if_utilization_key'] = if_util_key
        if_util_row['date'] = date_field.to_s
        if_util_row['day_in_month'] = date_dim_row['day_in_month']
        if_util_row['month_number'] = date_dim_row['month_number']
        if_util_row['quarter_number'] = date_dim_row['quarter_number']
        if_util_row['year'] = date_dim_row['year']
        if_util_row['week_number'] = date_dim_row['week_number']
        if_util_row['year_for_week'] = date_dim_row['year_for_week']
      end
      qos_stats_csv.each do |qos_stats_row|
        qos_stats_key += 1
        qos_stats_row['qos_stats_key'] = qos_stats_key
        qos_stats_row['date'] = date_field.to_s
        qos_stats_row['day_in_month'] = date_dim_row['day_in_month']
        qos_stats_row['month_number'] = date_dim_row['month_number']
        qos_stats_row['quarter_number'] = date_dim_row['quarter_number']
        qos_stats_row['year'] = date_dim_row['year']
        qos_stats_row['week_number'] = date_dim_row['week_number']
        qos_stats_row['year_for_week'] = date_dim_row['year_for_week']
      end
    end
  end

  # Iterate through date row
  puts "Generating Day #{day_generated + 1} if_util data\n"
  CSV.open("#{generated_files}day#{day_generated + 1}_if_util_fact_ib.csv", 'w', col_sep: '|') do |new_fact|
    if_util_csv.each do |row|
      new_fact << row
    end
  end
  puts "if_util data successfully created\n"
  puts "#{generated_files}day#{day_generated + 1}_if_util_fact_ib.csv"
  # Transfer data to server under test
  sftp_session.upload!("#{generated_files}day#{day_generated + 1}_if_util_fact_ib.csv", "/opt/emms/emsam/advance_reporting/bin/day#{day_generated + 1}_if_util_fact_ib.csv")
  # Insert data into table
  puts ssh_session.exec!("cd /opt/emms/emsam/advance_reporting/bin\n./dlpcsvloader.sh day#{day_generated + 1}_if_util_fact_ib.csv if_utilization_fact_ib")
  
  puts "Generating Day #{day_generated + 1} qos_stats data\n"
  CSV.open("#{generated_files}day#{day_generated + 1}_qos_stats_fact_ib.csv", 'w', col_sep: '|') do |new_fact|
    qos_stats_csv.each do |row|
      new_fact << row
    end
  end
  puts "qos_stats data successfully created\n"
  
  # Transfer data to server under test
  sftp_session.upload!("#{generated_files}day#{day_generated + 1}_qos_stats_fact_ib.csv", "/opt/emms/emsam/advance_reporting/bin/day#{day_generated + 1}_qos_stats_fact_ib.csv")
  # Insert data into table
  puts ssh_session.exec!("cd /opt/emms/emsam/advance_reporting/bin\n./dlpcsvloader.sh day#{day_generated + 1}_qos_stats_fact_ib.csv qos_stats_fact_ib")
end 

system("wget --no-check-certificate --no-proxy --read-timeout=0 -t 3 -w 40m -q -O - https://#{@hostname}/emsam/service/advrep/mondrian/refreshCache")