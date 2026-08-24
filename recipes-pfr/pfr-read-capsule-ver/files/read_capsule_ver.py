#!/usr/bin/env python3
import ctypes
import json

class QSYS_FW_VERSION_DATA(ctypes.Structure):
    _pack_ = 1
    _fields_ = [
        ("Signature", ctypes.c_ulonglong),
        ("Revision", ctypes.c_uint),
        ("VersionDataSize", ctypes.c_uint),
        ("VersionDataCrc32", ctypes.c_uint),
        ("FwVersion", ctypes.c_uint),
        ("LowestSupportedFwVersion", ctypes.c_uint),
    ]

    def to_bytes(self):
        try:
            return bytes(bytearray(self))
        except Exception as e:
            print(f"ERROR: Failure converting structure to byte array(error:{e})", e)
    
    @classmethod
    def from_bytes(cls, byte_arr):
        try:
            version_data = cls()
            ctypes.memmove(ctypes.addressof(version_data), byte_arr, ctypes.sizeof(version_data))   
            return version_data
        except Exception as e:
            print(f"ERROR: Failure converting byte array to structure(error:{e})", e)
            return None

if __name__ == "__main__":
    try:
        last_capsule_attempt = open("/sys/firmware/efi/esrt/entries/entry0/last_attempt_status").read().strip()
        print("Last capsule attempt status:", last_capsule_attempt)
        sysfw_version_data = open("/dev/disk/by-partlabel/SYSFW_VERSION", "rb").read()
        parsed_version_data = QSYS_FW_VERSION_DATA.from_bytes(sysfw_version_data)
        print("Parsed SYSFW_VERSION data:")
        print("Signature:", parsed_version_data.Signature)
        print("Revision:", parsed_version_data.Revision)
        print("VersionDataSize:", parsed_version_data.VersionDataSize)
        print("VersionDataCrc32:", parsed_version_data.VersionDataCrc32)
        print("FwVersion:", parsed_version_data.FwVersion)
        print("LowestSupportedFwVersion:", parsed_version_data.LowestSupportedFwVersion)
        json.dump({
            "last_capsule_attempt": last_capsule_attempt,
            "Signature": parsed_version_data.Signature,
            "Revision": parsed_version_data.Revision,
            "VersionDataSize": parsed_version_data.VersionDataSize,
            "VersionDataCrc32": parsed_version_data.VersionDataCrc32,
            "FwVersion": parsed_version_data.FwVersion,
            "LowestSupportedFwVersion": parsed_version_data.LowestSupportedFwVersion
        }, open("/tmp/last_capsule_status.json", "w"), indent=4)
    except Exception as e:
        print(f"ERROR: Failure reading SYSFW_VERSION file(error:{e})", e)