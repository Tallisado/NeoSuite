Sauce.config do |c|
	if !ENV['WR_NOTUNNEL'].nil? || ENV['WR_INTERFACE'] == 'local'
		puts "[WEBROBOT] (Sauce) Not using the tunnel for SauceConnect"
		c[:start_tunnel] = false
	end
	if ! ENV['WR_FFONLY'].nil?
		puts "[WEBROBOT] (Sauce) Targeted browsers - Firefox 19"
		c[:browsers] = [
			["Linux", "Firefox", "19"]
		]
	else
		puts "[WEBROBOT] (Sauce) Targeted browsers - Full Supported browser list"
		c[:browsers] = [
			["Windows 7", "Internet Explorer", "9"],
			["Linux", "Firefox", "19"],
			["OSX 10.6", "Chrome", nil]
		]
	end
end