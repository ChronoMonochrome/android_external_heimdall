LOCAL_PATH := $(call my-dir)

common_files := \
  Arguments.cpp \
  ClosePcScreenAction.cpp \
  DownloadPitAction.cpp \
  FlashAction.cpp \
  InfoAction.cpp \
  PrintPitAction.cpp \
  VersionAction.cpp \
  BridgeManager.cpp \
  DetectAction.cpp \
  HelpAction.cpp \
  Interface.cpp \
  Utility.cpp \
  main.cpp \
  ../../libpit/Source/libpit.cpp

include $(CLEAR_VARS)

LOCAL_SRC_FILES := $(common_files)
 
LOCAL_C_INCLUDES := \
  external/heimdall/libpit/Source \
  external/libusbx/libusb

LOCAL_STATIC_LIBRARIES := libusbx

ifeq ($(HOST_OS),darwin)
LOCAL_LDFLAGS := -framework CoreFoundation -framework IOKit
endif

ifeq ($(HOST_OS),linux)
LOCAL_LDFLAGS := -lpthread -lrt
endif

LOCAL_MODULE := heimdall
include $(BUILD_HOST_EXECUTABLE)

##### Device binary

include $(CLEAR_VARS)

LOCAL_SRC_FILES := $(common_files)

LOCAL_C_INCLUDES := \
  external/heimdall/libpit/Source \
  external/libusbx/libusb \
  external/stlport/stlport

LOCAL_C_INCLUDES += bionic

#  /usr/include/c++/4.8
##  prebuilts/ndk/9/sources/cxx-stl/gnu-libstdc++/4.8/libs/armeabi-v7a/include \
#  prebuilts/ndk/9/sources/cxx-stl/gnu-libstdc++/4.8/include

LOCAL_STATIC_LIBRARIES := libc libusbx libstlport_static
#libc libstdc++ libc++

#ifeq ($(HOST_OS),linux)
#LOCAL_LDFLAGS := -lpthread -lrt
#endif

LOCAL_CFLAGS := -Wno-non-virtual-dtor

LOCAL_FORCE_STATIC_EXECUTABLE := true

LOCAL_MODULE := heimdall
#LOCAL_CLANG := true
include $(BUILD_EXECUTABLE)

$(call dist-for-goals,dist_files sdk,$(LOCAL_BUILT_MODULE))
