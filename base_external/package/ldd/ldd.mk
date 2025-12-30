LDD_VERSION = '0fa6848cc5ffe3d06b065d2c6c9713cccbf20038'
LDD_SITE = git@github.com:cu-ecen-aeld/assignment-7-happysmaran.git
LDD_SITE_METHOD = git

# Let the infrastructure build BOTH subdirectories automatically
# This ensures they use the correct 6.12.27 kernel headers
LDD_MODULE_SUBDIRS = scull misc-modules

# Passing the include path to both subdirectories
LDD_MODULE_MAKE_OPTS = KCPPFLAGS="-I$(@D)/include"

define LDD_INSTALL_TARGET_CMDS
    # Install scull loading scripts
    $(INSTALL) -m 0755 $(@D)/scull/scull_load $(TARGET_DIR)/usr/bin/
    $(INSTALL) -m 0755 $(@D)/scull/scull_unload $(TARGET_DIR)/usr/bin/

    # Install misc-modules loading scripts
    $(INSTALL) -m 0755 $(@D)/misc-modules/module_load $(TARGET_DIR)/usr/bin/
    $(INSTALL) -m 0755 $(@D)/misc-modules/module_unload $(TARGET_DIR)/usr/bin/
endef

# The kernel-module infra handles .ko installation to /lib/modules/... automatically
$(eval $(kernel-module))
$(eval $(generic-package))
