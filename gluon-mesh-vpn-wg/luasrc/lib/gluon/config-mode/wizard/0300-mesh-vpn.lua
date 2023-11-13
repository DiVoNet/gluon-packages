local unistd = require 'posix.unistd'

local has_wireguard = unistd.access('/lib/gluon/mesh-vpn/provider/wireguard')

return function(form, uci)
	if not (has_wireguard) then
		return
	end

	local pkg_i18n = i18n 'gluon-mesh-vpn-wg'

	local msg = pkg_i18n.translate(
		'Your internet connection can be used to establish a ' ..
		'VPN connection with other nodes. ' ..
	    'Enable this option if there are no other nodes reachable ' ..
	    'over WLAN in your vicinity or you want to make a part of ' ..
	    'your connection\'s bandwidth available for the network. You can limit how ' ..
	    'much bandwidth the node will use at most.'
	)

	local s = form:section(Section, nil, msg)

	local o

	local meshvpn = s:option(Flag, "meshvpn", pkg_i18n.translate("Use internet connection (mesh VPN)"))
	meshvpn.default = uci:get_bool("wireguard", "mesh_vpn", "enabled")
	function meshvpn:write(data)
		if has_wireguard then
			uci:set("wireguard", "mesh_vpn", "enabled", data)
		end
	end

	local limit = s:option(Flag, "limit_enabled", pkg_i18n.translate("Limit bandwidth"))
	limit:depends(meshvpn, true)
	limit.default = uci:get_bool("simple-tc", "mesh_vpn", "enabled")
	function limit:write(data)
		uci:set("simple-tc", "mesh_vpn", "interface")
		uci:set("simple-tc", "mesh_vpn", "enabled", data)
		uci:set("simple-tc", "mesh_vpn", "ifname", "mesh-vpn")
	end

	local function div(n, d)
        if n then
            return n / d
        end
    end

    o = s:option(Value, "limit_ingress", pkg_i18n.translate("Downstream (Mbit/s)"))
	o:depends(limit, true)
	o.default = div(uci:get("simple-tc", "mesh_vpn", "limit_ingress"), 1000)
	o.datatype = "ufloat"
	function o:write(data)
		uci:set("simple-tc", "mesh_vpn", "limit_ingress", data * 1000)
	end

	o = s:option(Value, "limit_egress", pkg_i18n.translate("Upstream (Mbit/s)"))
	o:depends(limit, true)
	o.default = div(uci:get("simple-tc", "mesh_vpn", "limit_egress"), 1000)
	o.datatype = "ufloat"
	function o:write(data)
		uci:set("simple-tc", "mesh_vpn", "limit_egress", data * 1000)
	end

	return {'wireguard', 'simple-tc'}
end
