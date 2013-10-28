Pod::Spec.new do |s|
  s.name         = "KHGravatar"
  s.version      = "1.0.0"
  s.summary      = "An addition to AFNetworking to easily bring in Gravatar images."
  s.homepage     = "https://github.com/kcharwood/KHGravatar"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Kevin Harwood" => "kcharwood@gmail.com" }
  s.source       = { :git => "https://github.com/kcharwood/KHGravatar.git", :commit => "f6efe02" }
  s.platform     = :ios, '5.0'
  s.source_files = 'KHGravatar/KHGravatar.{h,m}'
  s.requires_arc = true
  
  s.subspec 'AFNetworking' do |ss|
    ss.dependency 'AFNetworking/UIKit', '~> 2.0'
    ss.source_files = 'KHGravatar/UIImageView+KHGravatar.{h,m}'
    s.platform     = :ios, '6.0'
  end
end
