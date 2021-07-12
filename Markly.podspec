Pod::Spec.new do |s|
  s.name         = "Markly"
  s.version      = "1.0.0"
  s.summary      = "Swift implementation of Markly. A micro subset of Markdown."
  s.homepage     = "https://github.com/raymondjavaxx/markly-swift"
  s.authors      = { 'Ramon Torres' => 'raymondjavaxx@gmail.com' }
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.ios.deployment_target  = "11.0"
  s.osx.deployment_target  = "10.15"

  s.source       = { :git => "https://github.com/raymondjavaxx/Markly.git", :tag => "#{s.version}" }
  s.source_files = "Markly/**/*.swift"
end
