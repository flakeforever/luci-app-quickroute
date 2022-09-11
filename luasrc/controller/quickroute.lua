module("luci.controller.quickroute", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/quickroute") then
		return
	end

	local page = entry({"admin", "network", "quickroute"},alias("admin", "network", "quickroute", "overview"), _("Quick Route"), 90)
	
	entry({"admin", "network", "quickroute", "overview"},cbi("quickroute/overview"),_("Overview"), 10).leaf = true
	entry({"admin", "network", "quickroute", "interface"},cbi("quickroute/interface"),_("Interface"), 20).leaf = true
	entry({"admin", "network", "quickroute", "mangle"},cbi("quickroute/mangle"),_("Mangle"), 30).leaf = true
end

