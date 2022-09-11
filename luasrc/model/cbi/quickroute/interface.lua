-- Copyright (C) 2017-2022 The Quick Route Authors.
-- Licensed to the public under the Apache License 2.0.

local sys = require "luci.sys"
local wa = require "luci.tools.webadmin"
local util = require "luci.util"
local uci = require "luci.model.uci"
local ip = require "luci.ip"

function cbi_add_interface(field)
	for k, v in ipairs(sys.net.devices()) do
		if v ~= "lo" then
			field:value(v)
		end
	end
end

map = Map("quickroute", translate("Quick Route"),
	translate("A quick routing configuration tool."))
--map.apply_on_parse = true
--map.on_after_apply = function(self)
--	sys.call("quickroute >/tmp/quickroute-log 2>&1 &")
--end

interface_list = map:section(TypedSection, "interface", translate("Interfaces"))
interface_list.template = "cbi/tblsection"
interface_list.anonymous = true
interface_list.addremove = true
interface_list.sortable  = false

interface = interface_list:option(Value, "name", translate("Interface"))
--interface.rmempty = true
--cbi_add_interface(interface)

gateway = interface_list:option(Value, "gateway", translate("Gateway (Bridging required)"))

return map
