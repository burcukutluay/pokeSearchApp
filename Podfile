# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'pokeSearchApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for pokeSearchApp
    pod 'Alamofire'
    pod 'AlamofireImage'
    pod 'CodableAlamofire'
    pod 'KeychainSwift'

  target 'pokeSearchAppTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Alamofire'
    pod 'AlamofireImage'
    pod 'CodableAlamofire'
    pod 'KeychainSwift'
  end

  target 'pokeSearchAppUITests' do
    # Pods for testing
    pod 'Alamofire'
    pod 'AlamofireImage'
    pod 'CodableAlamofire'
    pod 'KeychainSwift'
  end

end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = '$(inherited)'
        end
    end
end
