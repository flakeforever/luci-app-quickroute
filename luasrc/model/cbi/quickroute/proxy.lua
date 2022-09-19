-- Copyright (C) 2017-2022 The Quick Route Authors.
-- Licensed to the public under the Apache License 2.0.

local fs  = require "nixio.fs"
local sys = require "luci.sys"
local wa = require "luci.tools.webadmin"
local uci = require "luci.model.uci"

map = Map("trojan", translate("Trojan"),
	translate("A socks proxy."))
--map.apply_on_parse = true
--map.on_after_apply = function(self)
--	sys.call("quickroute >/tmp/quickroute-log 2>&1 &")
--end

interface_list = map:section(TypedSection, "proxy", translate("Proxy List"))
interface_list.template = "cbi/tblsection"
interface_list.anonymous = true
interface_list.addremove = true
interface_list.sortable  = false

interface = interface_list:option(Value, "name", translate("Name"))
--interface.rmempty = true
--cbi_add_interface(interface)

remote_addr = interface_list:option(Value, "remote_addr", translate("Remote Address"))
remote_port = interface_list:option(Value, "remote_port", translate("Remote Port"))
password = interface_list:option(Value, "password", translate("Password"))
sni = interface_list:option(Value, "sni", translate("SNI"))
ssl_verify = interface_list:option(Flag, "ssl_verify", translate("SSL Verify"))


return map
