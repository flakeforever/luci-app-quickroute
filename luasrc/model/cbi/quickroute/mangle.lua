-- Copyright (C) 2017-2022 The Quick Route Authors.
-- Licensed to the public under the Apache License 2.0.

local sys = require "luci.sys"
local wa = require "luci.tools.webadmin"

map = Map("quickroute", translate("Quick Route"),
	translate("A quick routing configuration tool."))
--map.apply_on_parse = true
--map.on_after_apply = function(self)
--	sys.call("quickroute >/tmp/quickroute-log 2>&1 &")
--end

default_section = map:section(TypedSection, "default", "Source Address")
default_section.anonymous = true

src = default_section:option(Value, "src_ip", translate("IP Address"))
src = default_section:option(Flag, "src_ipset_enabled", translate("IPSet Enabled"))
src = default_section:option(Value, "src_ipset_name", translate("IPSet Name"))
src = default_section:option(Flag, "src_ipset_inverted", translate("Match Inverted"))

default_section = map:section(TypedSection, "default", "Destination Address (Rule required)")
default_section.anonymous = true

dest = default_section:option(Value, "dest_ip", translate("IP Address"))
dest = default_section:option(Flag, "dest_ipset_enabled", translate("IPSet Enabled"))
dest = default_section:option(Value, "dest_ipset_name", translate("IPSet Name"))
dest = default_section:option(Flag, "dest_ipset_inverted", translate("Match Inverted"))

default_section = map:section(TypedSection, "default", "Others")
default_section.anonymous = true
dest = default_section:option(Value, "fwmark", translate("Firewall Mark"))
dest = default_section:option(Value, "route_table", translate("Route Table"))

return map
