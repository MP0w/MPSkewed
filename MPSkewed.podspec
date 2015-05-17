#
# Be sure to run `pod lib lint MPSkewed.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MPSkewed"
  s.version          = "0.9.0"
  s.summary          = "Skewed collection view cells with Parallax inspired by http://capptivate.co/2014/01/18/timbre-2/."
  
  s.description      = "A super-cool collection view cell and layout inspired by [this collectionView](http://capptivate.co/2014/01/18/timbre-2/)"
  
  s.homepage         = "https://github.com/MP0w/MPSkewed"
  s.screenshots      = "https://raw.githubusercontent.com/MP0w/MPSkewed/master/img/inaction.gif"
  s.license          = 'BSD'
  s.author           = { "Alex Manzella" => "manzopower@icloud.com" }
  s.source           = { :git => "https://github.com/MP0w/MPSkewed.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/manzopower'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Classes/'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit'
end
