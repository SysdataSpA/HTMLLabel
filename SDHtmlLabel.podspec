
Pod::Spec.new do |s|
  s.name             = 'SDHtmlLabel'
  s.version          = '1.1'
s.summary            = 'UILabel subclass able to manage HTML contents.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/SysdataSpA/HTMLLabel'
  s.license          = { :type => 'APACHE', :file => 'LICENSE' }
  s.author           = { 'Lorenzo Rossi' => 'l.rossi@sysdata.it' }
  s.source           = { :git => 'https://github.com/SysdataSpA/HTMLLabel.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'SDHtmlLabel/Classes/**/*'

  s.public_header_files = 'SDHtmlLabel/Classes/**/*.h'
end
