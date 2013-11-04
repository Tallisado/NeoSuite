class PPMAuthMacro

    def initialize(suite)
       @suite = suite
       #@suite.set_test_name(self.class.name)
    end

    def login_localadminuser
		@suite.p("-- login authentication macro...")
		@suite.selenium.navigate.to @suite.proper_base_url(@suite.common['ppm_homepage_nobase']) 
		@suite.wait_for_element_present(:id, "loginnameid-inputEl", 15)
		@suite.type(:id, "loginnameid-inputEl", @suite.common['adminuser_loginname'])
		@suite.type(:id, "loginpasswordid-inputEl", @suite.common['adminuser_loginpassword'])
		@suite.click(:id, "loginbuttonid-btnIconEl")
		@suite.wait_for_element_present(:id, "createUser_wiz", 20)
		@suite.verify { @suite.selenium.title.should == "ADTRAN Neo" }
	end	

    def login_ppmuser
		@suite.p("-- login authentication macro...")
		@suite.selenium.navigate.to @suite.proper_base_url(@suite.common['ppm_homepage_nobase'])
		@suite.wait_for_element_present(:id, "loginnameid-inputEl", 25)
		@suite.type(:id, "loginnameid-inputEl", @suite.common['ppmuser_loginname'])
		@suite.type(:id, "loginpasswordid-inputEl", @suite.common['ppmuser_loginpassword'])
		@suite.click(:id, "loginbuttonid-btnIconEl")
		# @suite.wait_for_element_present(:id, "localadminlogoutswitchid_switchview-btnWrap", 20)
		# @suite.click(:id, "localadminlogoutswitchid_switchview-btnWrap")
		@suite.wait_for_element_present(:id, "tcpAllVM_tab-btnInnerEl", 30)
		@suite.verify { @suite.selenium.title.should == @suite.common['pagetitle_authenticated'] }
	end	
	
	def login_ppmuser_mobile
		@suite.p("-- login authentication macro...")
		@suite.selenium.navigate.to @suite.proper_base_url(@suite.common['ppm_mobile_homepage_nobase'])
		@suite.wait_for_element_present(:id, "loginnameid-inputEl", 15)
		@suite.type(:id, "loginnameid-inputEl", @suite.common['ppmuser_loginname'])
		@suite.type(:id, "loginpasswordid-inputEl", @suite.common['ppmuser_loginpassword'])
		@suite.click(:id, "loginbuttonid-btnIconEl")
		@suite.wait_for_element_present(:id, "subtitle", 10)
		#@suite.verify { @suite.selenium.title.should == @suite.common['pagetitle_authenticated'] }
	end	
	
	def navigate_wizard
		@suite.p("-- naviagate to wizard...")
		@suite.selenium.navigate.to @suite.proper_base_url("")
		#@suite.wait_for_element_present(:id, "loginnameid-inputEl", 15)
		#@suite.type(:id, "loginnameid-inputEl", @suite.common['ppmuser_loginname'])
		#@suite.type(:id, "loginpasswordid-inputEl", @suite.common['ppmuser_loginpassword'])
		#@suite.click(:id, "loginbuttonid-btnIconEl")
		#@suite.wait_for_element_present(:id, "subtitle", 10)
		#@suite.verify { @suite.selenium.title.should == @suite.common['pagetitle_authenticated'] }
	end	
	
	def is_authenticated(assumption)
		@suite.p("-- is authentication macro...")
		@suite.selenium.navigate.to @suite.proper_base_url(@suite.common['ppm_homepage_nobase']) 
		@suite.verify { @suite.is_element_present(:id, "loginnameid-inputEl", 5).should == !assumption }
		if @suite.is_element_present(:id, "localadminlogoutswitchid_switchview-btnWrap", 5)
			@suite.click(:id, "localadminlogoutswitchid_switchview-btnWrap")
		end
	end	
end