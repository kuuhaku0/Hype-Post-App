# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'Hype Post App' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Hype Post App
pod 'Alamofire', '~> 4.5'
pod 'Firebase'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'Firebase/Storage'
pod 'GoogleSignIn'
pod 'Kingfisher', '~> 4.0'
pod 'SnapKit', '~> 4.0.0'
pod 'SVProgressHUD'
pod 'Material', '~> 2.13.5'


 swift4pods = ['Material']
 
 post_install do |installer|
   installer.pods_project.targets.each do |target|
     if swift4pods.include? target.name
       target.build_configurations.each do |config|
         config.build_settings['SWIFT_VERSION'] = '4.0'

	end
     end
   end
 end
end

