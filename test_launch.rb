system('ruby data_population.rb')
#sleep 600
#puts "Sleeping for 10 minutes"
system('rake smoke')
system('ruby spec\results_utility.rb smoke_tests')
