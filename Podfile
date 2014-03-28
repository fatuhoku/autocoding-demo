platform :ios, "7.0"

inhibit_all_warnings! # This will disable all the warnings for all pods!

target "BDDReactiveCocoa" do
  pod "ReactiveCocoa"
  pod "Functional.m"
  pod "libextobjc"
  pod "AutoCoding", :git => "git@github.com:nicklockwood/AutoCoding.git", :tag => "2.2"
  pod "HRCoder"
  pod "MagicalRecord"
end

target "BDDReactiveCocoaSpecs", :exclusive => true do
  pod "MagicalRecord"
  pod "Specta"
  pod "Expecta"
  pod "OCHamcrest"
  pod "OCMockito"
end
