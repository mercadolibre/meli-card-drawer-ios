source 'https://cdn.cocoapods.org/'

workspace 'MeliCardDrawer'
project 'Example_MeliCardDrawer/Example_MeliCardDrawer.xcodeproj'

# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
# ignore all warnings from all pods
inhibit_all_warnings!

# This plugin removes input and output files from 'Copy Pods Resources' build phases
# because this issue https://github.com/CocoaPods/CocoaPods/issues/7042
plugin 'cocoapods-clean_build_phases_scripts'

target 'Example_MeliCardDrawer' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # Pods for Example_MeliCardDrawer
  pod 'MLCardDrawer', :path => './'
  target 'Example_MeliCardDrawerTests' do
    	inherit! :search_paths
  end
end
