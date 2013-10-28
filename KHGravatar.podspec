Pod::Spec.new do |s|
  s.name         = "KHGravatar"
  s.version      = "1.0.0"
  s.summary      = "A library to easily build URLs for Gravatar profile images, and also includes an AFNetworking 2 extension."
  s.homepage     = "https://github.com/kcharwood/KHGravatar"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Kevin Harwood" => "kcharwood@gmail.com" }
  s.source       = { :git => "https://github.com/kcharwood/KHGravatar.git", :tag => "1.0.0" }
  s.platform     = :ios, '5.0'
  s.source_files = 'KHGravatar/KHGravatar.{h,m}'
  s.requires_arc = true
  
  s.subspec 'AFNetworking' do |ss|
    ss.dependency 'AFNetworking/UIKit', '~> 2.0'
    ss.source_files = 'KHGravatar/UIImageView+KHGravatar.{h,m}'
  end
end
