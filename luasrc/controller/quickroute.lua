module("luci.controller.quickroute", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/quickroute") then
		return
	end

	local page = entry({"admin", "network", "quickroute"},alias("admin", "network", "quickroute", "general"), _("Quick Route"), 90)
	
	entry({"admin", "network", "quickroute", "general"},cbi("quickroute/general"),_("Settings"), 10).leaf = true
	entry({"admin", "network", "quickroute", "interfaces"},cbi("quickroute/interfaces"),_("Interfaces"), 20).leaf = true
	entry({"admin", "network", "quickroute", "mangle"},cbi("quickroute/mangle"),_("Mangle"), 30).leaf = true
end

