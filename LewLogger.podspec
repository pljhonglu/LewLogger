Pod::Spec.new do |s|
  s.name         = "LewLogger"
  s.version      = "0.1.1"
  s.summary      = "简单的日志工具类，支持 unicode 中文显示，支持日志分级，支持 XcodeColors 着色。"
  s.homepage     = "https://github.com/pljhonglu/LewLogger"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "pljhonglu" => "pljhonglu@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/pljhonglu/LewLogger.git", :tag => "v0.1.1" }
  s.source_files = "LewLogger/*.{h,m}"
  s.requires_arc = true
end
