Pod::Spec.new do |s|
  s.name             = "MLCardDrawer"
  s.version          = "1.0.4"
  s.summary          = "MLCardDrawer for iOS"
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

  #s.test_spec do |test_spec|
    #test_spec.source_files = 'Example_MeliCardDrawer/Example_MeliCardDrawerTests/Tests/*'
    #test_spec.frameworks = 'XCTest'
  #end
end
