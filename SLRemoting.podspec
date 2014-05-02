Pod::Spec.new do |s|
  s.name     = 'SLRemoting'
  s.version  = '1.0.1'
  s.license  = { :type=> 'MIT & StrongLoop', :file=>'LICENSE' }
  s.summary  = 'iOS client for communicating with strong-remoting servers.'
  s.homepage = 'https://github.com/strongloop/strong-remoting-ios'
  s.authors  = { }
  s.source   = { :git => 'https://github.com/strongloop/strong-remoting-ios.git', :tag => '1.0.1' }
  s.source_files = 'SLRemoting'
  s.requires_arc = true

  s.ios.deployment_target = '6.1'
  s.ios.frameworks = 'UIKit', 'Foundation', 'SenTestingKit'

end
