# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pinger'
require 'pinger/version'

Gem::Specification.new do |spec|
  spec.name          = 'pinger'
  spec.version       = Pinger::VERSION
  spec.authors       = ['Sergey Bezugliy']
  spec.email         = ['s.bezugliy@gmail.com']
  spec.license       = 'Apache-2.0'

  spec.summary       = 'HTTP ping utility'
  spec.description   = <<-DESCRIPTION
    HTTP ping utility
  DESCRIPTION
  spec.homepage = 'https://github.org/sbezugliy'

  # Prevent pushing this gem to RubyGems.org.
  # To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section
  # to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.org/sbezugliy/pinger'
    # spec.metadata['changelog_uri'] = ''
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem
  # that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'codecov', '~> 0.1'
  spec.add_development_dependency 'pry', '~> 0.12'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.67.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.1.0'
  spec.add_development_dependency 'simplecov', '~> 0.16.0'
  spec.add_development_dependency 'simplecov-console', '~> 0.4.0'
end
