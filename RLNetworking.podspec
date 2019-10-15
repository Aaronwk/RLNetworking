#
# Be sure to run `pod lib lint RLNetworking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RLNetworking'
  s.version          = '0.1.1'
  s.summary          = '依赖于AFNetworking的网络工具。包括（GET POST请求），上传单个/多个文件，下载功能。'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Aaronwk' => 'jlrslwang@163.com' }
  s.source           = { :git => 'https://github.com/Aaronwk/RLNetworking.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'RLNetworking/**/*.{h,m}'
  
  # s.resource_bundles = {
  #   'RLNetworking' => ['RLNetworking/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'AFNetworking'
end
