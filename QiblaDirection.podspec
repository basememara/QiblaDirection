Pod::Spec.new do |s|
  s.name = 'QiblaDirection'
  s.version = '0.1.1'
  s.license = 'MIT'
  s.summary = 'Detects users angle to Kaaba in Swift'
  s.homepage = 'https://github.com/ethemozcan/QiblaDirection'
  s.social_media_url = 'https://tr.linkedin.com/in/ethemozcan'
  s.authors = { 'Ethem Ozcan' => 'ethemozcan@gmail.com' }
  s.source = { :git => 'https://github.com/ethemozcan/QiblaDirection.git', :tag => s.version }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'QiblaDirection' => ['Pod/Assets/*.png']
  }
end
