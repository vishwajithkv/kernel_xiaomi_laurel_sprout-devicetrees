# SPDX-License-Identifier: Apache-2.0
MI_A3_KERNEL_DEVICETREES := kernel/mainline/sm6125-mainline-6.18-devicetrees
# Keep the existing Kbuild target/output and appended-DTB packaging.
# Supply both paths: command-line DTC_INCLUDE overrides Kbuild's default.
TARGET_KERNEL_ADDITIONAL_FLAGS += DTC_INCLUDE="$(abspath $(MI_A3_KERNEL_DEVICETREES)) $(abspath $(TARGET_KERNEL_SOURCE))/scripts/dtc/include-prefixes"
