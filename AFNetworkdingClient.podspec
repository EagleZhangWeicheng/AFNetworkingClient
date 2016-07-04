Pod::Spec.new do |spec|
  spec.name         = 'AFNetworkingClient'
  spec.version      = '0.01'
  spec.license      = 'MIT'
  spec.summary      = 'Eagle client for the Pusher.com service'
  spec.homepage     = 'https://github.com/EagleZhangWeicheng/AFNetworkingClient'
  spec.author       = 'Luke Redpath'
  spec.source       = { :git => 'git://https://github.com/EagleZhangWeicheng/AFNetworkingClient.git', :tag => 'v0.01' }
  spec.source_files = 'Classes/*'
  spec.requires_arc = true
end
