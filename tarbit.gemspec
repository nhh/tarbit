lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "tarbit/version"

Gem::Specification.new do |s|

  s.name = 'tarbit'
  s.version = Tarbit::VERSION

  s.summary = "Summary"
  s.description = "Description"

  s.authors = ['Niklas Hanft']
  s.email = 'hello@niklashanft.com'
  s.homepage = 'https://github.com/nhh/apollo'
  s.license = 'ISC'

  s.files = `git ls-files`.split("\n")
  s.executables << 'tarbit'
  s.required_ruby_version = '~> 2.5'
  s.require_path = 'lib'

  # Dependencies
  s.add_dependency 'async-io'
  s.add_dependency 'commander'
  s.add_dependency 'gruff'

  # Development Dependencies

end
