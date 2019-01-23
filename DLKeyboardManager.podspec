#
#  Be sure to run `pod spec lint DLKeyboardManager.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "DLKeyboardManager"
  s.version      = "0.0.2"
  s.summary      = "方便监听Keyboard的show和hide."

  
  # s.description  = <<-DESC
  #                  DESC

  s.homepage     = "https://github.com/DaLangLove/DLKeyboardManager"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Dalang" => "magicianDL@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/DaLangLove/DLKeyboardManager.git", :tag => "#{s.version}" }
  s.source_files  = "DLKeyboardManager", "DLKeyboardManager/**/*.{h,m}"
  s.framework  = "UIKit"
  s.requires_arc = true

end
