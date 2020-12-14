include $(TOPDIR)/rules.mk

PKG_NAME:=gluon-divonet-files
PKG_VERSION:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/gluon-divonet-files
  SECTION:=gluon
  CATEGORY:=Gluon
  TITLE:= Different configfiles for DiVoNet
  DEPENDS:=
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/gluon-divonet-files/install
	$(CP) ./files/* $(1)/
endef

define Package/gluon-divonet-files/postinst
endef

$(eval $(call BuildPackage,gluon-divonet-files))
