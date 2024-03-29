local site_i18n = i18n 'gluon-site'

local uci = require("simple-uci").cursor()
local unistd = require 'posix.unistd'

local platform = require 'gluon.platform'
local site = require 'gluon.site'
local sysconfig = require 'gluon.sysconfig'
local util = require "gluon.util"

local pretty_hostname = require 'pretty_hostname'

local has_wireguard = unistd.access('/lib/gluon/mesh-vpn/provider/wireguard')

local hostname = pretty_hostname.get(uci)
local contact = uci:get_first("gluon-node-info", "owner", "contact")

local pubkey
local msg

if has_wireguard then
    local wireguard_enabled = uci:get_bool("wireguard", "mesh_vpn", "enabled")
	if wireguard_enabled then
		pubkey = util.trim(util.exec("uci get wireguard.mesh_vpn.privatekey | wg pubkey"))
		msg = site_i18n._translate('gluon-config-mode:pubkey')
	else
		msg = site_i18n._translate('gluon-config-mode:novpn')
	end
end

if not msg then return end

renderer.render_string(msg, {
	pubkey = pubkey,
	hostname = hostname,
	site = site,
	platform = platform,
	sysconfig = sysconfig,
	contact = contact,
})
