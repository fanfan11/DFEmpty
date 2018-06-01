Pod::Spec.new do |s|

  s.name         = "DFEmpty"
  s.version      = "0.0.1"
  s.summary      = "列表空白页显示"
  s.description  = <<-DESC
                    用于UITableView和UICollectionView显示空白页
                   DESC
  s.homepage     = "https://github.com/fanfan11"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Fanfan" => "fanfa.dong@camdora.me" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/fanfan11/DFEmpty", :tag => "#{s.version}" }

  s.source_files  = "Classes", "Sources/DFEmpty/*.{h,m}"
  #s.exclude_files = "Classes/Exclude"


end
