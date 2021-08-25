#
# Be sure to run `pod lib lint BankApp.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BankApp'
  s.version          = '0.1.0'
  s.summary          = 'A short description of BankApp.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/viniteixeira/BankApp'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'viniteixeira' => 'viniteixeira10@gmail.com' }
  s.source           = { :git => 'https://github.com/viniteixeira/BankApp.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  
  s.subspec "Core" do |sp|
    sp.source_files = ["BankApp/Classes/Core/**/*"]
    sp.resource_bundles = { "BankApp" => [
      "BankApp/Assets/*.{xcassets,png,storyboard,json,pdf}",
    ] }
  end
  
  s.subspec "Models" do |sp|
    sp.source_files = 'BankApp/Classes/Models/**/*'
    sp.dependency 'BankApp/Core'
  end
  
  s.subspec "Scenes" do |sp|
    sp.source_files = 'BankApp/Classes/Scenes/**/*'
    sp.dependency 'BankApp/Core'
  end
  
  s.subspec "Services" do |sp|
    sp.source_files = 'BankApp/Classes/Services/**/*'
    sp.dependency 'BankApp/Core'
  end
  
  s.subspec "Workers" do |sp|
    sp.source_files = 'BankApp/Classes/Workers/**/*'
    sp.dependency 'BankApp/Core'
  end
  
  s.dependency 'Alamofire', '~> 5.4'
end
