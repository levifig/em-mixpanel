$:.push('lib')
require "em/mixpanel/version"

Gem::Specification.new do |s|
  s.name    = 'em-mixpanel'
  s.version = EM::Mixpanel::VERSION.dup
  s.email   = 'chris@minefold.com'
  s.authors  = ['Chris Lloyd', 'Dave Newman']
  
  s.summary = 'Non-blocking Mixpanel API'
  
  s.add_dependency 'em-http-request'
  
  s.files         = Dir['**/*']
  s.test_files    = Dir['test/**/*'] + Dir['spec/**/*']
  s.executables   = Dir['bin/*'].map { |f| File.basename(f) }
  s.require_paths = ["lib"]
end
