Pod::Spec.new do |s|
  s.name             = "MLCardDrawer"
  s.version          = "1.5.1"
  s.summary          = "MLCardDrawer for iOS"
  s.homepage         = "https://github.com/mercadolibre/meli-card-drawer-ios"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = "Joni Bandoni"
  s.source           = { :git => "git@github.com:mercadolibre/meli-card-drawer-ios.git", :tag => s.version.to_s }

  s.platform         = :ios, '10.0'
  s.ios.deployment_target = '10.0'
  s.requires_arc     = true
  s.swift_version    = '5.0'
  s.default_subspec = 'Default'
  s.static_framework = true

  s.subspec 'Default' do |default|
    default.resources = ['Source/Assets/*.bundle']
    default.source_files = ['Source/Classes/**/*.{h,m,swift}']
    default.resource_bundles = { 'MLCardDrawerResources' => ['Source/Assets/*.xcassets', 'Source/Classes/**/*.xib'] }
  end
end
