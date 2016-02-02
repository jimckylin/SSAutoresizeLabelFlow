

Pod::Spec.new do |s|


  s.name         = "SSAutoresizeLabelFlow"
  s.version      = "0.0.1"
  s.summary      = "An autoresize label flow using UICollectionView."
  s.description  = <<-DESC
                   DESC

  s.homepage     = "https://github.com/jimckylin/SSAutoresizeLabelFlow"
  s.license      = "MIT (example)"

  s.source       = { :git => "https://github.com/jimckylin/SSAutoresizeLabelFlow.git", :commit => "d4de14bcf34a2feb6834bf3946eec39cf67669e9" }

  s.source_files  = "SSAutoresizeLabelFlow/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

end
