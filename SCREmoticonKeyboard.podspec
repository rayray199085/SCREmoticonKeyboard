Pod::Spec.new do |spec|
  spec.name         = "SCREmoticonKeyboard"
  spec.version      = "0.1.2"
  spec.summary      = "Custom emoticon keyboard"
  spec.homepage     = "https://github.com/rayray199085/SCREmoticonKeyboard"
  spec.license      = "MIT"
  spec.author             = { "Rui Cao" => "rayray199085@gmail.com" }
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/rayray199085/SCREmoticonKeyboard.git", :tag => spec.version }
  spec.source_files  = "SCREmoticonKeyboard", "Emoticon/**/*.{swift,xib}"
  spec.requires_arc = true
  spec.swift_version = '4.0'
  spec.resources = "Emoticon/Emoticons.bundle"
  spec.dependency "MJExtension", "~> 3.0.17"
  spec.dependency "SCRHintView", "~> 0.0.1"

end
