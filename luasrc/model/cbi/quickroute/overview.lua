-- Copyright (C) 2017-2022 The Quick Route Authors.
-- Licensed to the public under the Apache License 2.0.

local fs  = require "nixio.fs"
local sys = require "luci.sys"
local wa = require "luci.tools.webadmin"
local uci = require "luci.model.uci"
local cjson = require "luci.jsonc"

function get_proxy(name)
	result = {remote_addr = "", remote_port = 0, password = "", sni = "", ssl_verify = false}
	
	uci.cursor():foreach("trojan", "proxy",
    function (section)
		if section.name == name then
			result.remote_addr = section.remote_addr
			result.remote_port = tonumber(section.remote_port)
			result.password = section.password
			
			if section.sni ~= nil then
				result.sni = section.sni
			end
			if section.ssl_verify ~= nil then
				result.ssl_verify = section.ssl_verify
			end
		end
    end)
	
	return result
end

map = Map("trojan", translate("Trojan"),
	translate("A socks proxy."))
map.on_after_commit = function(self)
	current_proxy = uci.cursor():get_first("trojan", "trojan", "current_proxy")
	proxy = get_proxy(current_proxy)
	json = luci.jsonc.stringify({ 
		run_type = "client", 
		local_addr = uci.cursor():get_first("trojan", "trojan", "local_addr"), 
		local_port = uci.cursor():get_first("trojan", "trojan", "local_port"), 
		remote_addr = proxy.remote_addr,
		remote_port = proxy.remote_port,
		password = {proxy.password},
		ssl = { sni = proxy.sni, verify = proxy.ssl_verify } 
	})
	
	fs.writefile("/etc/trojan.json", json)
end
map.apply_on_parse = true
map.on_after_apply = function(self)
	sys.exec("/etc/init.d/trojan restart")
end

default_section = map:section(TypedSection, "trojan", translate("Quick Settings"))
default_section.anonymous = true

enabled = default_section:option(Flag, "enabled", translate("Enabled"))

interface = default_section:option(ListValue, "current_proxy", translate("Proxy"))
uci.cursor():foreach("trojan", "proxy",
    function (section)
		interface:value(section.name)
    end)
	
local_addr = default_section:option(Value, "local_addr", translate("Local Address"))
local_port = default_section:option(Value, "local_port", translate("Local Port"))

return map
