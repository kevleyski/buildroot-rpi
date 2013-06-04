QT5WAYLAND_VERSION = c2d41eee09a1c88641c6f866528c661728a0bf2f
QT5WAYLAND_SITE = git://gitorious.org/qt/qtwayland.git
QT5WAYLAND_SITE_METHOD = git

QT5WAYLAND_DEPENDENCIES = qt5base qt5xmlpatterns qt5jsbackend qt5declarative wayland

QT5WAYLAND_INSTALL_STAGING = YES

define QT5WAYLAND_CONFIGURE_CMDS
	-[ -f $(@D)/Makefile ] && $(MAKE) -C $(@D) distclean
#	(cd $(@D) && $(HOST_DIR)/usr/bin/qmake)
	(cd $(@D) && $(HOST_DIR)/usr/bin/qmake CONFIG+=wayland-compositor QT_WAYLAND_GL_CONFIG=egl)
endef

define QT5WAYLAND_BUILD_CMDS
 	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QT5WAYLAND_INSTALL_STAGING_CMDS
	$(MAKE) -C $(@D) install
endef

define QT5WAYLAND_INSTALL_TARGET_CMDS
	cp -dpf $(STAGING_DIR)/usr/lib/libQt5Compositor*.so* $(TARGET_DIR)/usr/lib
	cp -dpf $(STAGING_DIR)/usr/plugins/platforms/libqwayland-brcm-egl.so $(TARGET_DIR)/usr/plugins/platforms/
endef

define QT5WAYLAND_UNINSTALL_TARGET_CMDS
	-rm $(TARGET_DIR)/usr/lib/libQt5Compositor*.so*
	-rm $(TARGET_DIR)/usr/plugins/platforms/libqwayland-brcm-egl.so
endef

$(eval $(generic-package))

