Pod::Spec.new do |s|

  s.name         = "JWLunarCalendarDB"
  s.version      = "1.0.1"
  s.summary      = "LunarCalendar Data"
  s.homepage     = "https://github.com/Javen-fly/JWLunarCalendarDB"
  s.license      = "MIT"
  s.author       = { "Javenfly" => "960838547@qq.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/Javen-fly/JWLunarCalendarDB.git", :tag => "1.0.1" }

  s.source_files  = "JWLunarCalendarDB", "JWLunarCalendarDB/**/*.{h,m}"
  s.framework     = "UIKit"

end
