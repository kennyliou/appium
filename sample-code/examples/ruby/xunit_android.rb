# this test show you how to use flick and locate element by parent container
# it open the system settings ui, and click the 'About phone' item to find android version
# create by testerhome.com
# author: seveniruby

<<<<<<< HEAD
require "test/unit"
=======
require 'test/unit'
>>>>>>> 5472fa6ace842e42f69dd23fbaea9d887298e2a3
require 'selenium-webdriver'

def capabilities
	{
		'browserName' => 'android',
		'platform' => 'linux',
		'version' => '4.1',
<<<<<<< HEAD
		"app-activity"=> ".Settings",
		"app-package"=> "com.android.settings"
=======
		'app-activity'=> '.Settings',
		'app-package'=> 'com.android.settings'
>>>>>>> 5472fa6ace842e42f69dd23fbaea9d887298e2a3
	}
end

def init(data={})
<<<<<<< HEAD
	server_url = "http://127.0.0.1:4723/wd/hub"
	driver = Selenium::WebDriver.for(:remote, :desired_capabilities => capabilities.merge(data), :url => server_url)
	driver.manage.timeouts.implicit_wait = 20 # seconds
	return(driver)
=======
	server_url = 'http://127.0.0.1:4723/wd/hub'
	driver = Selenium::WebDriver.for(:remote, :desired_capabilities => capabilities.merge(data), :url => server_url)
	driver.manage.timeouts.implicit_wait = 20 # seconds
	driver
>>>>>>> 5472fa6ace842e42f69dd23fbaea9d887298e2a3
end

class SettingsTest < Test::Unit::TestCase
	def setup
		@driver=init
	end
	def test_settings
		#flick the screen until find the Aboud phone item 
		while @driver.find_elements(:xpath, '//text[@text="About phone"]').count==0
			begin
				@driver.execute_script 'mobile: flick', :startY=>0.9, :endY=>0.1
			rescue
			end
		end
		about=@driver.find_element(:xpath, '//text[@text="About phone"]')
		about.click
		#parent select, locate the container
		version_setting=@driver.find_element(:xpath, '//list/linear[4]/relative')
		#child select
		version_value=version_setting.find_element(:xpath, '//text[2]')
		#check the version, should be 4.1.2 or other version string
		assert_not_equal nil, version_value.text=~/[0-9\.]/
	end
	def teardown
		@driver.quit
	end
end
