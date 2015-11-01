# Uncomment this line to define a global platform for your project
# platform :ios, '6.0'
target 'SnapArt' do
    pod 'FacebookImagePicker'
    post_install do |installer|
        installer.pods_project.build_configuration_list.build_configurations.each do |configuration|
            configuration.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
        end
    end
    pod  'FBSDKLoginKit'
#    pod 'InstagramKit'
    pod 'AFNetworking'
    pod 'SDWebImage', '~> 3.7.2'
    pod 'InstagramKit/UICKeyChainStore'
    pod  'Braintree'
    use_frameworks!
    pod  'Alamofire'
    pod 'AlamofireImage', '~> 2.0'
    pod 'SwiftyJSON'
    #pod 'Facebook-iOS-SDK'
end
target 'SnapArtTests' do
    
end

