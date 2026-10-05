# Mi A3 6.18 kernel device trees

This repository owns the SM6125, PM6125, PMI632 and Mi A3 board descriptions
used by the split kernel. `qcom/` contains the complete local DTS include
closure. Binding headers come from the matching ACK kernel.

Imported changes retain the original authors and dates; see IMPORT_HISTORY.txt
and the kernel's Documentation/android/patch-provenance.json. Memory reservations are unchanged from the pre-split baseline. Subsequent
bringup changes are documented below.

Lineage includes BoardConfigDevicetrees.mk. Thin includes in the kernel retain
the existing qcom/sm6125-xiaomi-laurel-sprout-bringup.dtb target and output path.
DTC_INCLUDE selects this repository and the matching kernel binding headers.
Keep DTS changes here; do not edit the kernel include adapters.

Companions: sm6125-mainline-6.18 and sm6125-mainline-6.18-modules, all siblings
under kernel/mainline/. This split awaits a maintainer build and boot check.
See the kernel Documentation/android/SPLIT_SOURCES.md for integration/fallback.

SM6125 CPU frequency domains are now described in qcom/sm6125.dtsi, using
the companion kernel's SM6125 twelve-entry OSM LUT support. This integration
is not yet built or validated. See Documentation/android/CPUFREQ.md in the
kernel repository for hardware references and the maintainer acceptance steps.

FT3518 touch is enabled in the bringup DTS using the imported board wiring:
I2C2, QUP0, GPI DMA0 and ts_vdd_supply. The companion kernel builds the touch
and transport drivers in for both recovery and normal boot. GPI DMA1, native
display/GPU and removable storage remain disabled. This enablement is not yet
built or device validated; see kernel Documentation/android/TOUCH_DISPLAY.md.

2026-10-05 validation supersedes the pending statements above: the maintainer
built the split sources and confirmed recovery touch and physical Android
display transition; live ADB confirmed both CPU frequency policies and boot
completion. Sideload completes but its performance remains under investigation.
