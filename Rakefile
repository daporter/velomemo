require 'bundler'
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc "Run watchr"
task :watchr do
  sh %{bundle exec watchr .watchr}
end
