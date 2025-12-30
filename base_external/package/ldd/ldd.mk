LDD_VERSION = '0fa6848cc5ffe3d06b065d2c6c9713cccbf20038'
LDD_SITE = 'git@github.com:cu-ecen-aeld/assignment-7-happysmaran.git'
LDD_SITE_METHOD = git

define LDD_BUILD_CMDS
	$(MAKE) $(LINUX_MAKE_FLAGS) -C $(LINUX_DIR) M=$(@D)/scull modules
	$(MAKE) $(LINUX_MAKE_FLAGS) -C $(LINUX_DIR) M=$(@D)/misc-modules modules
endef

define LDD_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/scull/scull_load $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/scull/scull_unload $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/misc-modules/module_load $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/misc-modules/module_unload $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0644 $(@D)/scull/scull.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/scull.ko
	$(INSTALL) -D -m 0644 $(@D)/misc-modules/faulty.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/faulty.ko
	$(INSTALL) -D -m 0644 $(@D)/misc-modules/hello.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/hello.ko
endef

$(eval $(generic-package))
