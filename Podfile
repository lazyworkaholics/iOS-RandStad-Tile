# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def commonPods
  pod 'Reachability'
  pod 'MBProgressHUD', '~> 1.1.0'
end

target 'RandStadPOC' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  commonPods

  target 'RandStadPOCTests' do
    inherit! :search_paths
    commonPods
  end

  target 'RandStadPOCUITests' do
    commonPods
  end

end
