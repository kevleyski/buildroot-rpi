#############################################################
#
# rpi-userland
#
#############################################################

RPI_USERLAND_VERSION = 725b03007b0f53525767539bb435bdcfeed5ea66
RPI_USERLAND_SITE = http://github.com/raspberrypi/userland/tarball/master
RPI_USERLAND_LICENSE = BSD-3c
RPI_USERLAND_LICENSE_FILES = LICENCE
RPI_USERLAND_INSTALL_STAGING = YES
RPI_USERLAND_CONF_OPT = -DVMCS_INSTALL_PREFIX=/usr -DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -DNDEBUG"

define RPI_USERLAND_POST_STAGING_PKGCONFIG
	(cd $(STAGING_DIR)/usr/include; ln -sfn VG vg)
	cp -f package/rpi-userland/bcm_host.pc $(STAGING_DIR)/usr/lib/pkgconfig/
endef

define RPI_USERLAND_POST_TARGET_CLEANUP
	rm -f $(TARGET_DIR)/usr/bin/raspi*
	rm -f $(TARGET_DIR)/etc/init.d/vcfiled
	rm -Rf $(TARGET_DIR)/usr/src
endef

RPI_USERLAND_POST_INSTALL_STAGING_HOOKS += RPI_USERLAND_POST_STAGING_PKGCONFIG
RPI_USERLAND_POST_INSTALL_TARGET_HOOKS += RPI_USERLAND_POST_TARGET_CLEANUP

$(eval $(cmake-package))
