Pod::Spec.new do |s|
    s.name         = "MSPScrollView"
    s.version      = "0.1.0"
    s.summary      = "图片轮播控件"
    s.description  = <<-DESC
                      图片轮播控件
                     DESC
    s.homepage     = "https://github.com/rayesquire/MSPScrollView"
    
    s.license      = 'MIT'
    s.author       = { "MaShaopeng" => "fantastic.msp@gmail.com" }
    #s.social_media_url = ""
    s.source       = { :git => "https://github.com/rayesquire/MSPScrollView.git", :tag => s.version.to_s }
  
    s.platform     = :ios, '7.0'
    s.requires_arc = true
  
    # s.source_files = 'YXYNumberAnimationLabel/**/*.{h,m}'
    s.frameworks = 'Foundation', 'UIKit'
    
    #s.dependency '', '~> 0.1'
  end