Pod::Spec.new do |s|
  s.name = 'QiblaDirection'
  s.version = '0.0.1'
  s.license = 'MIT'
  s.summary = 'Detects users angle to Kaaba in Swift'
  s.homepage = 'https://github.com/ethemozcan/QiblaDirection'
  s.social_media_url = 'https://tr.linkedin.com/in/ethemozcan'
  s.authors = { 'Ethem Ozcan' => 'ethemozcan@gmail.com' }
  s.source = { :git => 'https://github.com/ethemozcan/QiblaDirection.git', :tag => s.version }

  s.ios.deployment_target = '8.0' 

  s.source_files = 'QiblaDirection.swift'

  s.requires_arc = true
end
