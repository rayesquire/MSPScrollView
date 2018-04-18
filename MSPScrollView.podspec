Pod::Spec.new do |s|
  s.name             = 'MSPScrollView'
  s.version          = '0.1.0'
  s.summary          = 'A short description of MSPScrollView.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/rayesquire/MSPScrollView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rayesquire' => 'mashaopeng@meituan.com' }
  s.source           = { :git => 'https://github.com/rayesquire/MSPScrollView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'MSPScrollView/Classes/**/*'
  
  s.resource_bundles = {
    'MSPScrollView' => ['MSPScrollView/Assets/*.{png,jpg}', 'MSPScrollView/MSPScrollView.xcassets']
  }
  # s.resources = ['MSPScrollView/Assets/*.{png,jpg}', 'MSPScrollView/MSPScrollView.xcassets']

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'SDWebImage'
end
