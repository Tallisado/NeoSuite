spec = Gem::Specification.new do |s|
  s.author = 'Tallis Vanek'
  s.email = 'tallis.vanek@adtran.com'

  s.name = 'webrobot'
  s.version = '0.2'
  s.summary = 'Ruby selenium display API'

  s.description = <<-EOF
    WebRobot is a Ruby GEM wrapper for selenium-webdriver, which allows you to create headed, headless and cloud browser tests while hiding lower level actions
  EOF
  s.requirements = 'Xvfb'
  s.requirements = 'vlc'
  s.homepage = 'https://github.com/Tallisado/NeoSuite'

  s.files         = `git ls-files`.split("\n")

  s.add_development_dependency 'rake'
  s.add_development_dependency "rspec", "~> 2.6"
end
