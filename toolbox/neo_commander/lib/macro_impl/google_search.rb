class GoogleSearchMacro

    def initialize(suite)
       @suite = suite
       @suite.set_test_name(self.class.name)
    end

    # -- test begins
    def run_test
		puts ENV['SELENIUM_DRIVER']
        @suite.selenium.navigate.to "http://am-centos1.objectworld.com/PPM/LandingPage.html"
        @suite.selenium.title.include?("PPM")
    end
end
