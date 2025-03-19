#
#  Be sure to run `pod spec lint DcsCardSdk.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name                = "DCSApplyCardSDK"
  spec.version             = "1.4.4"
  spec.summary             = "DCSApplyCardSDK is a powerful SDK for digital card applications, authentication, and management."
  spec.description         = <<-DESC
  DCSApplyCardSDK provides a comprehensive solution for digital card applications, user authentication,  
card issuance, and lifecycle management. It is designed for financial institutions and fintech companies  
to integrate secure and seamless digital card services into their applications.

Key Features:
- User authentication and token-based authorization  
- Digital card application and issuance  
- Card status tracking and management  
- Secure PIN reset functionality  

DCSApplyCardSDK is optimized for iOS applications and supports seamless integration with Jumio for identity verification.
                   DESC

  spec.homepage            = "https://github.com/decard-tech/dcs-apply-card-sdk"
  spec.license             = { :type => 'MIT', :file => 'LICENSE' }
  spec.author              = { "Ryan" => "ryan.an@dcsserv.com" }
  spec.source              = {
    :git => 'https://github.com/decard-tech/dcs-apply-card-sdk.git', 
    :tag => "#{spec.version}"
  }
  
  spec.platform            = :ios, '14.0'
  spec.swift_version       = '5.5'

  spec.vendored_frameworks = 'framework/DcsCardSdk.xcframework'
  
  spec.dependency 'Jumio/All', '4.12.0'
end
