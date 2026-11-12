#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)
ifneq ($(TARGET_PREBUILT_KERNEL),)
KERNEL_HEADERS_DIR := $(dir $(TARGET_PREBUILT_KERNEL))kernel-headers

$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr: $(TARGET_PREBUILT_KERNEL) $(wildcard $(KERNEL_HEADERS_DIR)/*) $(wildcard $(KERNEL_HEADERS_DIR)/*/*)
	@echo "Staging prebuilt kernel headers: $(KERNEL_HEADERS_DIR) -> $@"
	@mkdir -p $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ
	@rm -rf $@
	@mkdir -p $@/include
	@cp -a $(KERNEL_HEADERS_DIR)/* $@/include/
	@touch $@
endif

