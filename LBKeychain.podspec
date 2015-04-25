Pod::Spec.new do |s|

  s.name         = "LBKeychain"
  s.version      = "1.0.0"
  s.summary      = "A keychain wrapper to help you save username and password very easy"
  s.description  = <<-DESC
                   LBKeychain is a keychain wrapper for iOS.
                   It offers:
                   - methods to search, save and delete a value to keychain.
                   - a method to search for the username, a method to save the username and password and a method to delete the username and password.
                   - an autocomplete method for username and password.
                   DESC

  s.homepage     = "https://github.com/lucianboboc/LBKeychain"
  s.license      = "MIT"
  s.author             = { "Lucian Boboc" => "info@lucianboboc.com" }
  s.social_media_url = 'http://twitter.com/lucianboboc'
  s.source       = { :git => "https://github.com/lucianboboc/LBKeychain.git", :tag => "1.0.0" }

  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files  = "LBKeychain/*.{h,m}"

end
