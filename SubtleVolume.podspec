Pod::Spec.new do |s|
  s.name = 'SubtleVolume'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'Replace the system volume popup with a more subtle indicator'
  s.description  = <<-DESC
                  Drop in control that shows the system volume when the user changes it with the volume rocker in a more subtle and less obtrusive way.
                   DESC
  s.homepage = 'https://github.com/andreamazz/SubtleVolume'
  s.social_media_url = 'https://twitter.com/theandreamazz'
  s.authors = { 'Andrea Mazzini' => 'andrea.mazzini@gmail.com' }
  s.source = { :git => 'https://github.com/andreamazz/SubtleVolume.git', :tag => s.version }

  s.ios.deployment_target = '8.0'
  s.swift_version = '4.2'
  s.source_files = 'Source/*.swift'

  s.requires_arc = true
end
