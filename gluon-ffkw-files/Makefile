include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-ffkw-files
PKG_VERSION:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/gluon-ffkw-files
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:= Different configfiles for Freifunk Koenigswinter
  DEPENDS:=
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/gluon-ffkw-files/install
	$(CP) ./files/* $(1)/
endef

define Package/gluon-ffkw-files/postinst
endef

$(eval $(call BuildPackage,gluon-ffkw-files))
