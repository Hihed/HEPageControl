Pod::Spec.new do |s|
  s.name         = "HEPageControl"
  s.version      = "0.0.1"
  s.summary      = "A short description of HEPageControl."

  s.description  = <<-DESC
                   DESC

  s.homepage     = "https://github.com/Hihed"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "wangqs" => "wangqs3@gmail.com" }

  s.platform     = :ios

  s.source       = { :git => "https://github.com/Hihed/HEPageControl.git"}

  s.source_files  = "HEPageControl/**/*.{h,m}"

  s.framework  = "UIKit"

  s.requires_arc = true

end
