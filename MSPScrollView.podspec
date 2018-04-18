Pod::Spec.new do |s|
  s.name             = 'MSPScrollView'
  s.version          = '0.1.3'
  s.summary          = 'A simple image scroll tool'
  s.description      = '一个简单的图片轮播控件,可以自定义page control'

  s.homepage         = 'https://github.com/rayesquire/MSPScrollView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rayesquire' => 'mashaopeng@meituan.com' }
  s.source           = { :git => 'https://github.com/rayesquire/MSPScrollView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'MSPScrollView/Classes/**/*'
  
  s.resource_bundles = {
    'MSPScrollView' => ['MSPScrollView/Assets/*.{png,jpg}', 'MSPScrollView/MSPScrollView.xcassets']
  }
  s.frameworks = 'UIKit'
  s.dependency 'SDWebImage'
end
