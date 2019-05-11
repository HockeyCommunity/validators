lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hc/validators/version'

Gem::Specification.new do |spec|
  spec.name          = 'hc-validators'
  spec.version       = '0.1.0'
  spec.authors       = ['Jack Hayter']
  spec.email         = ['jack@hockey-community.com']

  spec.summary       = 'A super simple object serializer'
  spec.description   = 'Transforms objects and collections into hashes for rendering as JSON'
  spec.homepage      = 'https://github.com/HockeyCommunity/validators'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'activemodel'
end
