Pod::Spec.new do |s|
  s.name             = 'GeocoderKit'
  s.version          = '0.0.1'
  s.summary          = "A drop-in replace for Apple's CLGeocoder class to allow multiple providers and provide failure handling with backup services"
  s.description      = <<-DESC
  Apple's geocoder is used extensibly in iOS development. However, when it comes to results, it is not always the most accurate or user friendly geocoder available. On the other hand, there are a plethora of thrid party providers for geocoding services, each offering their own API and model definitions, that despite being similar, are not equal. 
  This library aims for providing a unique interface for any existing service keeping Apple's Core Location API and model to allow quick integration into existing applications. Besides, it offers a fail over mechanism that allows for returning results even when the default provider fails: it will always try to resolve the geocoding request with the array of providers given (in sequential order), until one succeeds.
                       DESC

  s.homepage         = 'https://github.com/angelolloqui/GeocoderKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Angel G. Olloqui' => "https://angelolloqui.com" }
  s.source           = { :git => 'https://github.com/angelolloqui/GeocoderKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/angelolloqui'
  s.ios.deployment_target = '10.0'

  s.source_files = 'Sources/**/*'
  s.swift_version = '5.0'
  s.frameworks = 'CoreLocation'
end
