Pod::Spec.new do |s|
  s.name             = "MeliCardDrawer"
  s.version          = "1.0"
  s.summary          = "MeliCardDrawer for iOS"
  s.homepage         = "https://www.mercadolibre.com"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = "Juan Sanzone"
  s.source           = { :git => "https://github.com/mercadolibre/meli-card-drawer-ios", :tag => s.version.to_s }
  s.swift_version    = '4.2'
  s.platform         = :ios, '9.0'
  s.requires_arc     = true
  s.source_files     = 'Source/Classes/**/*.{h,m,swift}'
  s.resources        = "Source/Classes/**/*.xib",
  "Source/Assets/*.bundle",
  "Source/Assets/*.xcassets"
end