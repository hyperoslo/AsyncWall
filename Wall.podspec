Pod::Spec.new do |s|
  s.name             = "Wall"
  s.version          = "0.1.0"
  s.summary          = "Wall"
  s.homepage         = "https://github.com/hyperoslo/Wall"
  s.license          = {
    :type => 'MIT',
    :file => 'LICENSE.md'
  }
  s.author           = {
    "Hyper" => "ios@hyper.no"
  }
  s.source           = {
    :git => "https://github.com/hyperoslo/Wall.git",
    :tag => s.version.to_s
  }
  s.social_media_url = 'https://twitter.com/hyperoslo'

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.requires_arc = true

  s.source_files = 'Source/*'

  s.dependency 'AsyncDisplayKit', '~> 1.2'

  s.frameworks = 'Foundation'
end
