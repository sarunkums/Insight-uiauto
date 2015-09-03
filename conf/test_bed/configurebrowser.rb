file_name = 'C:\Insight 1.0\Prime_Insight 1.0\conf\test_bed\pi_auto_prop.yml'

browserType = ARGV[0]

text = File.read(file_name)

final_text = text.gsub(/browserType:.*/, "browserType: #{browserType}")

File.open(file_name, "w") {|file| file.puts final_text}

puts final_text