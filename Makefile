GO_EASY_ON_ME = 1
THEOS_DEVICE_IP = 192.168.1.92
export SDKVERSION=8.1
TARGET_IPHONEOS_DEPLOYMENT_VERSION = 6.0
# ADDITIONAL_CFLAGS = -fobjc-arc

include theos/makefiles/common.mk

BUNDLE_NAME = AutoCorrect
AutoCorrect_FILES = Switch.xm
AutoCorrect_FRAMEWORKS = UIKit
AutoCorrect_PRIVATE_FRAMEWORKS = GraphicsServices
AutoCorrect_LIBRARIES = flipswitch
AutoCorrect_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk

# internal-stage::
#     #PreferenceLoader plist
#     $(ECHO_NOTHING)if [ -f Preferences.plist ]; then mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/AutoCorrect; cp Preferences.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/AutoCorrect/; fi$(ECHO_END)

after-install::
	install.exec "killall -9 SpringBoard"
