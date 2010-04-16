begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "zoolahr"
    gemspec.summary = "Zoolah Ruby Library"
    gemspec.email = "support@zoolah.com"
    gemspec.homepage = "http://zoolah.com"
    gemspec.description = "Access the Zoolah APIs through nice Ruby wrapper"
    gemspec.authors = ["Justin Saul"]
    gemspec.has_rdoc = false
    gemspec.add_dependency("ruby-hmac", [">= 0.3.1"])
    gemspec.add_dependency("oauth", [">= 0.2.4"])
    gemspec.add_dependency("json", [">= 1.1.3"])
    gemspec.add_dependency("activesupport", [">= 2.0.2"])
    gemspec.files = []
    gemspec.files << "README.rdoc"
    gemspec.files << "License.txt"
    gemspec.files << "VERSION.yml"
    gemspec.files << "Rakefile"
    gemspec.files += Dir.glob("example/**/*")
    gemspec.files += Dir.glob("lib/**/*")
    gemspec.files += Dir.glob("spec/**/*")
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end