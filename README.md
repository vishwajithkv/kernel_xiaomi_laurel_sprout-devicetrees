# Mi A3 6.18 kernel device trees

The native Mi A3 profile now omits the MDSS core reset consumer as a
board-specific boot workaround. On 2026-10-06, DTB-only isolation with build
#15 showed MDSS-parent-only recovery failing with the reset request and
booting without it. Full native recovery also boots without the request;
ADB confirms bound MDSS/DPU/DSI/PHY drivers, a connected DSI connector and
renderD128. Android boot and repeated reboot stability with this workaround
are pending. Source changes have not been compiled; the maintainer tested
repacked images using the existing kernel and ramdisk.

Subsequent build #16 includes this workaround: full ROM sideload succeeds,
Android on B completes boot with Freedreno FD610 and physical display, and
the maintainer confirms an Android reboot survives. Recovery remains alive
but black; panel command initialization still times out early in both boot
paths. See NATIVE_GRAPHICS.md for the separate, uncompiled DSI controller
startup candidate. The reset bypass alone does not fix panel startup.

The shared SM6125 reset description and provider remain intact, including
their original authorship. The statements below describe earlier validation;
the native profile override supersedes reset consumption for this board.

The MDSS core reset wiring now carries upstream Mi A3 fix bb4d28e377cf by
Val Packett, retaining authorship and review/test trailers. The companion
kernel must also contain the matching DISPCC reset provider and ID binding.
Rebuild kernel and DTB together. The maintainer's 2026-10-06 build #15
validated native physical scanout with the companion kernel corrections.
The upstream Tested-by trailer is distinct from this local validation.

The SM6125 DSI PHY now exposes its downstream-verified lane-clamp register
resource to the companion kernel. Build #15 combines this resource with the
MDSS reset and prepared-PLL restart corrections and has working physical
display output. Rebuild kernel and DTB together. See the companion
kernel Documentation/android/NATIVE_GRAPHICS.md for provenance and evidence.

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

Modem source integration now carries the five attributed laurel-connectivity
patches. This is unvalidated kernel support with manual firmware startup;
Android telephony and the RMTFS userspace service remain pending. See the
companion kernel Documentation/android/MODEM.md and modem-provenance.json.

Native graphics source profile: qcom/sm6125-xiaomi-laurel-sprout-native.dts
includes the existing bringup DTS and re-enables its attributed GPU, SMMU,
clock and MDSS/DSI nodes. Memory reservations and imported panel wiring/timing
are preserved. The ROM selects this DTB with its native graphics profile.
The 2026-10-06 native build boots Android with physical scanout and live
DEVICE composition confirmed during Settings scrolling; see the kernel
Documentation/android/NATIVE_GRAPHICS.md for firmware, panel-module packaging
and the explicit SimpleDRM fallback.

## Binding ownership and module layout

Board-carried schemas live in the devicetrees repository under bindings/:
SM6125 DISPCC, Qualcomm hardware cpufreq, 14nm DSI PHY, Samsung S6E8FCO,
EDT FT3518 and the SM6115/SM6125 PAS modem. The carried SM6125 DISPCC
header lives under include/dt-bindings/clock/. Shared upstream bindings and
headers remain in ACK. Kernel paths contain relative compatibility symlinks
to these external files, so kernel C includes, existing schema IDs/references
and ACK dt_binding_check discovery retain their normal locations. Edit the
external files, not a second copy in the kernel. Keep the sibling paths.
BINDING_HISTORY.json records hashes and original carried commit authors/dates;
all original commits remain intact in the kernel repository.

The external panel driver is now maintained at
qcom/opensource/display-drivers/panel/ in the modules repository, matching the
vendor directory convention used by the OnePlus reference. Lineage's kbuild
module hook and the standalone helper select this path. Build outputs are
ignored, not checked in. The ROM dependencies include external schemas and
binding headers as well as DTS and driver sources.

This layout refactor preserves source bytes, configuration and boot packaging.
It requires a maintainer rebuild of matching kernel, DTB and modules; earlier
native-display validation applies to the pre-refactor build. No build, test or
flash was performed for this refactor.
