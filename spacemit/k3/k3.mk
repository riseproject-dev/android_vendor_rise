#
# Copyright (C) 2026 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Firmware for SpacemiT K3 Pico-ITX

PRODUCT_SOONG_NAMESPACES += vendor/rise/spacemit/k3

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
