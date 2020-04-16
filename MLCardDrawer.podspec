Pod::Spec.new do |s|
  s.name             = "MLCardDrawer"
  s.version          = "1.4.6"
  s.summary          = "MLCardDrawer for iOS"
  s.homepage         = "https://www.mercadolibre.com"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = "Joni Bandoni"
  s.source           = { :git => "https://github.com/mercadolibre/meli-card-drawer-ios.git", :tag => s.version.to_s }
  s.swift_version    = '5.0'
  s.platform         = :ios, '9.0'
  s.requires_arc     = true
  s.default_subspec = 'Default'

  s.subspec 'Default' do |default|
    default.resources = ['Source/Classes/**/*.xib', 'Source/Assets/*.bundle', 'Source/Assets/*.xcassets']
    default.source_files = ['Source/Classes/**/*.{h,m,swift}']
  end
end
