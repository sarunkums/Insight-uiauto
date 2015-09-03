require 'rubygems'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'
require 'yaml'

ENV['CI_REPORTS']='reports'

desc "Homepage Custom Dashboard and Dashlet Testing"

RSpec::Core::RakeTask.new(:homepage_rest) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/home/home_spec_rest.rb'
  spec.fail_on_error = false
end

RSpec::Core::RakeTask.new(:homepage_gettingStarted) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/home/getting_started_spec.rb'
  spec.fail_on_error = false
end

RSpec::Core::RakeTask.new(:homepage_telemetry) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/home/telemetry_spec.rb'
  spec.fail_on_error = false
end

RSpec::Core::RakeTask.new(:homepage_customdash) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/home/home_spec.rb'
  spec.fail_on_error = false
end

RSpec::Core::RakeTask.new(:interfaceutilization) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/home/interfaceutilization_spec.rb'
  spec.fail_on_error = false
end

RSpec::Core::RakeTask.new(:error_and_discards) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/home/errors_and_discards_spec.rb'
  spec.fail_on_error = false
end

RSpec::Core::RakeTask.new(:qos) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/home/qos_spec.rb'
  spec.fail_on_error = false
end

RSpec::Core::RakeTask.new(:customviewpage_saiku) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/Report/customviews_spec.rb'
  spec.fail_on_error = false
end

RSpec::Core::RakeTask.new(:report_template_schedule_report) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/Report/saved_schedule_report_spec.rb'
  spec.fail_on_error = false
end

RSpec::Core::RakeTask.new(:user_management) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/administration/user_management_spec.rb'
  spec.fail_on_error = false
end

RSpec::Core::RakeTask.new(:singleSignOn) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/administration/single_sign_on_spec.rb'
  spec.fail_on_error = false
end

RSpec::Core::RakeTask.new(:data_source) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/administration/system_setup/data_source_spec.rb'
  spec.fail_on_error = false
end

RSpec::Core::RakeTask.new(:email_settings) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/administration/system_setup/email_settings_spec.rb'
  spec.fail_on_error = false
end

RSpec::Core::RakeTask.new(:log_config) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/administration/system_setup/log_config_spec.rb'
  spec.fail_on_error = false
end

RSpec::Core::RakeTask.new(:backup_spec) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/administration/system_setup/backup_spec.rb'
  spec.fail_on_error = false
end


RSpec::Core::RakeTask.new(:PISuserReport) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/Report/pis_UserReports_spec.rb'
  spec.fail_on_error = false
end


RSpec::Core::RakeTask.new(:smoketest) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/smoke.rb'
  spec.fail_on_error = false
end

RSpec::Core::RakeTask.new(:sanity) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/sanity.rb'
  spec.fail_on_error = false
end

task :rspec => 'ci:setup:rspec'

desc "Execute All Test Cases"

task :smoke => [:rspec, :smoketest]
  
task :mainTask => [:rspec,:homepage_gettingStarted,:homepage_telemetry,:email_settings,:homepage_customdash,:interfaceutilization,:error_and_discards,:qos,:customviewpage_saiku,:report_template_schedule_report,:user_management,:singleSignOn,:data_source,:log_config,:backup_spec]
  
task :iteration34 => [:rspec, :PISuserReport]
