# Mi A3 6.18 kernel device trees

This repository owns the SM6125, PM6125, PMI632 and Mi A3 board descriptions
used by the split kernel. `qcom/` contains the complete local DTS include
closure. Binding headers come from the matching ACK kernel.

Imported changes retain the original authors and dates; see IMPORT_HISTORY.txt
and the kernel's Documentation/android/patch-provenance.json. The bringup DTS
and memory reservations are byte-identical to the pre-split baseline.

Lineage includes BoardConfigDevicetrees.mk. Thin includes in the kernel retain
the existing qcom/sm6125-xiaomi-laurel-sprout-bringup.dtb target and output path.
DTC_INCLUDE selects this repository and the matching kernel binding headers.
Keep DTS changes here; do not edit the kernel include adapters.

Companions: sm6125-mainline-6.18 and sm6125-mainline-6.18-modules, all siblings
under kernel/mainline/. This split awaits a maintainer build and boot check.
See the kernel Documentation/android/SPLIT_SOURCES.md for integration/fallback.
