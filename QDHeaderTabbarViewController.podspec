#
# Be sure to run `pod lib lint QDHeaderTabbarViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QDHeaderTabbarViewController'
  s.version          = '0.1.0'
  s.summary          = '头部滚动视图控制器.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'header tabbr  controller'

  s.homepage         = 'https://github.com/dongqihouse/QDHeaderTabbarViewController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '244514311@qq.com' => '244514311@qq.com' }
  s.source           = { :git => 'https://github.com/dongqihouse/QDHeaderTabbarViewController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'QDHeaderTabbarViewController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'QDHeaderTabbarViewController' => ['QDHeaderTabbarViewController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SnapKit'
end
