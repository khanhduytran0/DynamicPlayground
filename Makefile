ARCHS := arm64
PACKAGE_FORMAT := ipa
TARGET := iphone:clang:latest:16.0

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = DynamicPlaygroundLib
DynamicPlaygroundLib_FILES = AppDelegate.m SceneDelegate.m FakeSBWindowScene.m ViewController.m
DynamicPlaygroundLib_FRAMEWORKS = UIKit
DynamicPlaygroundLib_PRIVATE_FRAMEWORKS = SpringBoardFoundation SpringBoardServices SpringBoard
DynamicPlaygroundLib_CFLAGS = -fcommon -fobjc-arc -Wno-error
DynamicPlaygroundLib_INSTALL_PATH = /Applications/DynamicPlayground.app
include $(THEOS_MAKE_PATH)/library.mk

APPLICATION_NAME = DynamicPlayground
DynamicPlayground_FILES = main.m
DynamicPlayground_FRAMEWORKS = UIKit
DynamicPlayground_PRIVATE_FRAMEWORKS = BaseBoard
DynamicPlayground_CFLAGS = -fcommon -fobjc-arc -Wno-error
DynamicPlayground_CODESIGN_FLAGS = -Sentitlements.xml

include $(THEOS_MAKE_PATH)/application.mk
