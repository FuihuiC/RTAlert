
Pod::Spec.new do |s|

  s.name         = "RTAlert"
  s.version      = "0.0.1"
  s.summary      = "RTAlert is used instead of UIAlertController."
  s.description  = <<-DESC
  Sample alert. 
                   DESC

  s.homepage     = "https://github.com/FuihuiC"

  s.license      = "MIT"


  s.author       = { "ENUUI" => "ENUUI_C@163.com" }
  s.platform     = :ios, "8.0"

  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/FuihuiC/RTAlert.git", :tag => "#{s.version}" }

  s.source_files  = "RTAlert/core/*.{h,m}", 'RTAlert/*.{h,m}'
  s.public_header_files = "RTAlert/*.h", 'RTAlert/core/RTAlertController.h', 'RTAlert/core/RTActionItem.h'
end
