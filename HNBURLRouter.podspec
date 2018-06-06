Pod::Spec.new do |s|
  s.name         = "HNBURLRouter"
  s.version      = "0.0.5"
  s.summary      = "url router"
  s.homepage     = "https://github.com/ByronChengChen/HNBURLRouter"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "chengkang" => "chengkang_boy@163.com" }
  s.source       = { :git => "https://github.com/ByronChengChen/HNBURLRouter.git", :tag => "0.0.4" }
  s.platform     = :ios, '8.0'
  s.source_files  = "HNBURLRouter", "HNBURLRouter/HNBURLRouter/**/*"
end
