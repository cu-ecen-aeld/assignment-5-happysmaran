##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
AESD_ASSIGNMENTS_VERSION = '803868aef79b0d34cf4cf19957a757f788f24bc9'
AESD_ASSIGNMENTS_SITE = 'git@github.com:cu-ecen-aeld/assignments-3-and-later-happysmaran.git'
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

# This tells Buildroot that this package needs the Linux kernel to build
AESD_ASSIGNMENTS_DEPENDENCIES = linux

define AESD_ASSIGNMENTS_BUILD_CMDS
	# Build the user-space socket server
	$(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D)/server aesdsocket
	
	# Build the kernel modules (scull and faulty)
	# You must pass the kernel directory (LINUX_DIR) and cross-compiler
	$(MAKE) $(LINUX_MAKE_FLAGS) -C $(@D)/misc-modules modules
	$(MAKE) $(LINUX_MAKE_FLAGS) -C $(@D)/scull modules
endef

define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	# Install the socket server
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket

	# Install the kernel modules to the correct location in /lib/modules
	$(INSTALL) -d $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/
	$(INSTALL) -m 0644 $(@D)/scull/scull.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/
	$(INSTALL) -m 0644 $(@D)/misc-modules/faulty.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/
	$(INSTALL) -m 0644 $(@D)/misc-modules/hello.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/
endef

$(eval $(generic-package))
