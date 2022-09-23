-- Copyright (C) 2017-2022 The Quick Route Authors.
-- Licensed to the public under the Apache License 2.0.

local sys = require "luci.sys"
local wa = require "luci.tools.webadmin"
local uci = require "luci.model.uci"

map = Map("quickroute", "%s - %s" %{translate("Quick Route"), translate("Settings")})
--map.apply_on_parse = true
--map.on_after_apply = function(self)
--	sys.call("quickroute >/tmp/quickroute-log 2>&1 &")
--end

default_section = map:section(TypedSection, "default", translate("Quick Switch"))
default_section.anonymous = true

mode = default_section:option(ListValue, "mode", translate("Current Mode"))
mode:value("direct", "Direct")
mode:value("rule", "Rule")
mode:value("global", "Global")

interface = default_section:option(ListValue, "interface", translate("Interface"))
uci.cursor():foreach("quickroute", "interface",
    function (section)
		interface:value(section.name)
    end)
	
return map
