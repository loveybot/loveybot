require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec) do |t|
  end

  task :default do
    Rake::Task["spec"].invoke
  end