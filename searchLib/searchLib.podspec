#
#  Be sure to run `pod spec lint searchLib.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "searchLib"
 s.version      = "1.0.1"
 s.summary      = "test library creation"
 s.license      = "none"
 s.author       = {"Ignacio Giagante" => "ignacio.giagante@mercadolibre.com"}
 s.platform     = :ios, "8.0"
 s.requires_arc = true
 s.homepage     = 'https://github.com/tonymillion/Reachability'
 s.source       = { :git => 'https://github.com/tonymillion/Reachability.git', :tag => 'v3.1.0' }
 s.source_files = "LibraryComponents/Classes/**/*.{h,m}"
 s.resources    = "LibraryComponents/**/*.xib", "LibraryComponents/Assets/**/*.xcassets", "LibraryComponents/Assets/**/*.plist", "LibraryComponents/Assets/**/*.ttf"

end
