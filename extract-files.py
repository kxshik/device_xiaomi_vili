#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)
from extract_utils.makefiles import (
    MakefilesCtx,
    ProductPackagesCtx,
    write_mk_guard_begin,
    write_mk_guard_end,
)

namespace_imports = [
    "hardware/xiaomi",
]


def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f"{lib}_{partition}" if partition == "vendor" else None


lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    (
        "com.qualcomm.qti.dpm.api@1.0",
        "libmmosal",
        "vendor.qti.hardware.wifidisplaysession@1.0",
        "vendor.qti.imsrtpservice@3.0",
        "vendor.qti.diaghal@1.0",
    ): lib_fixup_vendor_suffix,
}

blob_fixups: blob_fixups_user_type = {
    "system/framework/WfdCommon.jar": blob_fixup()
        .apktool_patch("blob-patches/WfdCommon.patch"),
    "system_ext/lib64/libwfdservice.so": blob_fixup()
        .replace_needed("android.media.audio.common.types-V4-cpp.so", "android.media.audio.common.types-V5-cpp.so"),
    "vendor/etc/camera/pureShot_parameter.xml": blob_fixup()
        .regex_replace(r"=(\d+)>", r"="">"),
    "vendor/etc/libnfc-nxp.conf": blob_fixup()
        .regex_replace(r"NXP_T4T_NFCEE_ENABLE=0x01", r"NXP_T4T_NFCEE_ENABLE=0x00"),
    "vendor/etc/camera/vili_motiontuning.xml": blob_fixup()
        .regex_replace("xml=version", "xml version"),  
    "vendor/lib/hw/audio.primary.vili.so": blob_fixup()
        .replace_needed("/vendor/lib/liba2dpoffload.so", "/odm/lib/liba2dpoffload.so")
        .replace_needed("/vendor/lib/libssrec.so", "/odm/lib/libssrec.so")
        .replace_needed("libaudioroute.so", "libaudioroute-v34.so"),
    "vendor/lib/libaudioroute_ext.so": blob_fixup()
        .replace_needed("libaudioroute.so", "libaudioroute-v34.so"),
    "vendor/lib64/hw/camera.qcom.so": blob_fixup()
        .binary_regex_replace(b"\x73\x74\x5F\x6C\x69\x63\x65\x6E\x73\x65\x2E\x6C\x69\x63", b"\x63\x61\x6D\x65\x72\x61\x5F\x63\x6E\x66\x2E\x74\x78\x74")
        .add_needed("libprocessgroup_shim.so")
        .replace_needed("libtinyxml2.so", "libtinyxml2-v34.so"),
    "vendor/lib64/hw/camera.xiaomi.so": blob_fixup()
        .sig_replace("50 07 00 94", "1F 20 03 D5"),
    ("vendor/lib64/hw/com.qti.chi.override.so", "vendor/lib64/libmialgoengine.so"): blob_fixup()
         .add_needed("libprocessgroup_shim.so"),
    "vendor/lib64/vendor.xiaomi.hardware.cameraperf@1.0-impl.so": blob_fixup()
        .sig_replace("21 00 80 52 7c 00 00 94", "21 00 80 52 1F 20 03 D5"),
    "vendor/lib/libaudiocloudctrl.so": blob_fixup()
        .replace_needed("libtinyxml2.so", "libtinyxml2-v34.so"),
    "vendor/etc/init/vendor.xiaomi.hardware.citsensorservice@1.1-service.rc": blob_fixup()
        .add_line_if_missing("    task_profiles ServiceCapacityLow"),
    ("vendor/etc/media_lahaina/video_system_specs.json", "vendor/etc/media_shima_v1/video_system_specs.json", "vendor/etc/media_yupik_v1/video_system_specs.json"): blob_fixup()
        .regex_replace("\"max_retry_alloc_output_timeout\": 10000,", "\"max_retry_alloc_output_timeout\": 0,"),
    "vendor/etc/vintf/manifest/c2_manifest_vendor.xml": blob_fixup()
        .regex_replace(".*ozoaudio.*\n?", "")
        .regex_replace(".*dolby.*\n?", ""),
    ("vendor/lib64/mediadrm/libwvdrmengine.so", "vendor/lib64/libwvhidl.so"): blob_fixup()
        .add_needed("libcrypto_shim.so"),
    "vendor/lib64/android.hardware.secure_element@1.0-impl.so": blob_fixup()
        .remove_needed("android.hidl.base@1.0.so"),
    ("vendor/lib64/libdpps.so", "vendor/lib64/libsnapdragoncolor-manager.so"): blob_fixup()
        .replace_needed("libtinyxml2.so", "libtinyxml2-v34.so"),
    "vendor/lib64/libmisight.so": blob_fixup()
        .add_needed("libjsoncpp_shim.so")
        .add_needed("libmisightjson_shim.so"),
}  # fmt: skip


def android_mk_guard_begin(ctx: MakefilesCtx, _: ProductPackagesCtx):
    write_mk_guard_begin("TARGET_DEVICE", "vili", ctx.mk_out)


def android_mk_guard_end(ctx: MakefilesCtx, _: ProductPackagesCtx):
    write_mk_guard_end(ctx.mk_out)


module = ExtractUtilsModule(
    "vili",
    "xiaomi",
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
    add_firmware_proprietary_file=False,
)

module.add_proprietary_file(
    "proprietary-files.txt",
    pre_makefile_generation_fn=android_mk_guard_begin,
    post_makefile_generation_fn=android_mk_guard_end,
)

if __name__ == "__main__":
    utils = ExtractUtils.device(module)
    utils.run()
