include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-mesh-vpn-wireguard
PKG_VERSION:=1
PKG_RELEASE:=1

include $(TOPDIR)/../package/gluon.mk

define Package/gluon-mesh-vpn-wireguard
  TITLE:=Support for connecting meshes via wireguard
  DEPENDS:=+gluon-mesh-vpn-core +gluon-config-mode-core +micrond +kmod-gre +kmod-wireguard +wireguard-tools +kmod-udptunnel4 +curl +ca-bundle +ip-full
endef

$(eval $(call BuildPackageGluon,gluon-mesh-vpn-wireguard))
