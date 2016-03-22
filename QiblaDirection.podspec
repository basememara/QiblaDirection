Pod::Spec.new do |s|
    s.name = 'QiblaDirection'
    s.version = '0.2.1'
    s.license = 'MIT'
    s.summary = 'Detects users angle to Kaaba in Swift'
    s.homepage = 'https://github.com/ethemozcan/QiblaDirection'
    s.social_media_url = 'https://tr.linkedin.com/in/ethemozcan'
    s.authors = { 'Ethem Ozcan' => 'ethemozcan@gmail.com' }
    s.source = { :git => 'https://github.com/ethemozcan/QiblaDirection.git', :tag => s.version }

    s.ios.deployment_target = "8.4"
    s.watchos.deployment_target = "2.0"
    s.tvos.deployment_target = "9.0"

    s.requires_arc = true

    s.source_files = "Sources/**/*.{h,swift}"
end
