Pod::Spec.new do |spec|
  spec.name         = 'EagleAFNetworking'
  spec.version      = '0.01'
  spec.license      = 'MIT'
  spec.summary      = 'Eagle client for the AFNetworking service'
  spec.homepage     = 'https://github.com/EagleZhangWeicheng/AFNetworkingClient'
  spec.author       = 'Eagle Zhang'
  spec.source       = { :git => 'git://https://github.com/EagleZhangWeicheng/AFNetworkingClient.git', :tag => 'v0.01' }
  spec.source_files = 'Classes/*'
  spec.requires_arc = true


  spec.dependency     'AFNetworking'


end
