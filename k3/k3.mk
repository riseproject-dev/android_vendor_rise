#
# Copyright (C) 2026 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Firmware for SpacemiT K3 Pico-ITX

PRODUCT_SOONG_NAMESPACES += vendor/spacemit/k3
# Also import the K1 vendor namespace so we can pull its rtw8852b_fw.bin module
# (chip-identical WiFi firmware, reused — see the WiFi note below). Importing a
# namespace only makes its modules referenceable; nothing installs unless it is
# in PRODUCT_PACKAGES.
PRODUCT_SOONG_NAMESPACES += vendor/spacemit/k1

# WiFi RTL8852BE firmware (rtw89/rtw8852b_fw.bin). The blob is chip-identical to
# the K1's, which already provides a globally-visible "rtw8852b_fw.bin"
# prebuilt_firmware module installing to /vendor/firmware/rtw89/. Reuse THAT one
# module directly — any K3-side installer (a second prebuilt_firmware OR a
# PRODUCT_COPY_FILES) for the same path collides with it (make "overriding
# commands for target"). Pulling the single canonical module is conflict-free.
#
# rtw89 asks newest-first (RTW8852B_FW_FORMAT_MAX = 2 -> tries -2, then -1, then
# plain), so the set of files present decides which firmware runs. Ship -1 but
# NOT -2: with -2 available the driver loads 0.29.128.0 and the card scans without
# finding anything, while Bianbu on this same board runs -1.bin (0.29.29.15) and
# scans fine — its older driver stops at format 1. Omitting -2 lands our driver on
# the firmware known to work here.
PRODUCT_PACKAGES += \
    rtw8852b_fw.bin \
    rtw8852b_fw-1.bin

# Bluetooth RTL8852B firmware (btusb + btrtl, USB)
PRODUCT_PACKAGES += \
    rtl8852bu_fw.bin \
    rtl8852bu_config.bin
