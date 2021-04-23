# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Foody Cook Book' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

    # Image Loader
    pod 'Kingfisher', '5.15.8'
    # Reachabily Framework
    pod 'ReachabilitySwift', '5.0.0'
    # Toast
    pod 'KSToastView', '0.5.7'
    # ProgressHud
    pod 'SVProgressHUD'
    # Drop Down Menu
    pod 'DropDown'

  # Pods for Foody Cook Book

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
        end
    end
end
