# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{zoolahr}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Justin Saul"]
  s.date = %q{2010-03-17}
  s.description = %q{Access the Zoolah APIs through nice Ruby wrapper}
  s.email = %q{support@zoolah.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "License.txt",
     "README.rdoc",
     "Rakefile",
     "VERSION.yml",
     "example/zoolahtoken.rb",
     "lib/zoolah/base.rb",
     "lib/zoolah/client.rb",
     "lib/zoolah/user.rb",
     "lib/zoolahr.rb",
     "spec/client_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://zoolah.com}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Zoolah Ruby Library}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruby-hmac>, [">= 0.3.1"])
      s.add_runtime_dependency(%q<oauth>, [">= 0.2.4"])
      s.add_runtime_dependency(%q<json>, [">= 1.1.3"])
      s.add_runtime_dependency(%q<activesupport>, [">= 2.0.2"])
    else
      s.add_dependency(%q<ruby-hmac>, [">= 0.3.1"])
      s.add_dependency(%q<oauth>, [">= 0.2.4"])
      s.add_dependency(%q<json>, [">= 1.1.3"])
      s.add_dependency(%q<activesupport>, [">= 2.0.2"])
    end
  else
    s.add_dependency(%q<ruby-hmac>, [">= 0.3.1"])
    s.add_dependency(%q<oauth>, [">= 0.2.4"])
    s.add_dependency(%q<json>, [">= 1.1.3"])
    s.add_dependency(%q<activesupport>, [">= 2.0.2"])
  end
end
