ARCHS = arm64
TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = 1


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Modding

Modding_FILES = Tweak.x
Modding_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
