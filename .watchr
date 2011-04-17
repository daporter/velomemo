watch("spec/.*/*_spec\.rb")  { |m| run_spec m[0] }
watch("lib/.*/(.*).rb")      { |m| run_spec "spec/#{m[1]}_spec.rb" }
watch("spec/spec_helper.rb") { run "rake spec" }

Signal.trap('QUIT') { run "rake spec"  }
Signal.trap('INT')  { abort("\n") }

def run_spec(file)
  unless File.exist?(file)
    puts "#{file} does not exist"
    return
  end

  run "bundle exec rspec #{file}"
end

def run(cmd)
  puts   cmd
  system cmd
  puts
end
