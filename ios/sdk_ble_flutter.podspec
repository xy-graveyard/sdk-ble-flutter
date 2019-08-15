#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'sdk_ble_flutter'
  s.version          = '0.0.5'
  s.swift_version    = '4.0'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'https://xyo.network'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'support@xyo.network' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*.{h,m,swift,xcdatamodeld}'
  s.resources = 'Classes/Xyo*.xcdatamodeld'
  s.public_header_files = 'Classes/**/*.h'
  
  s.dependency 'Flutter'
  s.dependency 'XyBleSdk', '~> 0.0.2'
  s.dependency 'SwiftProtobuf', '~> 1.5'
  s.dependency 'sdk-bletcpbridge-swift', '~> 0.1.2-beta.0'
  s.dependency 'sdk-xyobleinterface-swift', '~> 0.1.5-beta.3'
  s.dependency 'sdk-core-swift', '~> 0.1.6-beta.8'

  s.ios.deployment_target = '11.0'
end
