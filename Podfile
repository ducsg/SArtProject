# Uncomment this line to define a global platform for your project
# platform :ios, '6.0'
target 'SnapArt' do
    pod 'FacebookImagePicker', '~> 2.0.6'
    post_install do |installer|
        installer.pods_project.build_configuration_list.build_configurations.each do |configuration|
            configuration.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
        end
    end
    pod  'FBSDKLoginKit', '~> 4.6.0'
    pod 'InstagramKit', '~> 3.0'
    pod 'SDWebImage', '~> 3.7.2'
    pod 'InstagramKit/UICKeyChainStore'
    pod  'Braintree', '~> 3.9.6'
    use_frameworks!
    pod  'Alamofire' , '~> 3.1.3'
    pod 'AlamofireImage', '~> 2.0'
    pod 'SwiftyJSON', '~> 2.3.1'
#    pod 'AsyncImageView-blocks', '~> 1.5'

    #pod 'Facebook-iOS-SDK'
#    pod 'LMGeocoder'
end
target 'SnapArtTests' do
    
end

