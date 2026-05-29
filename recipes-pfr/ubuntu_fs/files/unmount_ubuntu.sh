# Run this on the host (outside chroot).
# If you are still inside chroot, run `exit` first.

set +e

# Unmount bind-mounted GPU/camera libraries (file mounts)
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_crc_internal.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_demangle_internal.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_debugging_internal.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_exponential_biased.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_crc32c.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_sink.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_strings_internal.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_int128.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_malloc_internal.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_symbolize.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_kernel_timeout_internal.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_graphcycles_internal.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_stacktrace.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_cordz_handle.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_cordz_functions.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_crc_cord_state.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_cord_internal.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_low_level_hash.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_city.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_base.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_globals.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_globals.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_log_sink_set.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_strerror.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_proto.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_format.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_examine_stack.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_raw_logging_internal.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_throw_delegate.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_spinlock_wait.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_strings.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_str_format_internal.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_time_zone.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_time.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_synchronization.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_cordz_info.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_cord.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_status.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_hash.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_raw_hash_set.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_nullguard.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_conditions.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_statusor.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_die_if_null.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_message.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_check_op.so.2401.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libprotobuf.so.25.3.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libprotobuf.so.30 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libgstqtiallocatorsbase.so.1.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libgstqtiallocatorsbase.so.1 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libgstqtiallocatorsbase.so || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_utils.so.1.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_utils.so.1 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_utils.so || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_proto.so.1.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_proto.so.1 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_proto.so || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_propertyvault.so || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libgstqtivideobase.so.1.0.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libgstqtivideobase.so.1 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libgstqtivideobase.so || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_camera_metadata.so.1.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_camera_metadata.so.1 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_camera_metadata.so || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_recorder_client.so.1.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_recorder_client.so.1 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_recorder_client.so || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libcamera_metadata.so.0.1.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libcamera_metadata.so.0 || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libcamera_metadata.so || true
umount /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/gstreamer-1.0/libgstqtiqmmfsrc.so || true

umount /mnt/ubuntu24/usr/lib/libpropertyvault.so.0 || true
umount /mnt/ubuntu24/usr/lib/libOpenCL_adreno.so || true
umount /mnt/ubuntu24/usr/lib/libOpenCL_adreno.so.1 || true
umount /mnt/ubuntu24/usr/lib/libOpenCL.so || true
umount /mnt/ubuntu24/usr/lib/libOpenCL.so.1 || true
umount /mnt/ubuntu24/usr/lib/libllvm-qcom.so || true
umount /mnt/ubuntu24/usr/lib/libllvm-qcom.so.1 || true
umount /mnt/ubuntu24/usr/lib/libgsl.so || true
umount /mnt/ubuntu24/usr/lib/libgsl.so.1 || true
umount /mnt/ubuntu24/usr/lib/libdmabufheap.so.0 || true
umount /mnt/ubuntu24/usr/lib/libcdsprpc.so || true
umount /mnt/ubuntu24/usr/lib/libCB.so || true
umount /mnt/ubuntu24/usr/lib/libCB.so.1 || true
umount /mnt/ubuntu24/usr/lib/libadreno_utils.so.1 || true

# Unmount configs
umount /mnt/ubuntu24/var/opt/pfr || true
umount /mnt/ubuntu24/var/cache/camera || true

# Unmount fundamental mappings (sub-mounts first)
umount /mnt/ubuntu24/dev/pts || true
umount /mnt/ubuntu24/dev/shm || true
umount /mnt/ubuntu24/dev || true
umount /mnt/ubuntu24/sys || true
umount /mnt/ubuntu24/proc || true
umount /mnt/ubuntu24/tmp || true

# finally unmount rootfs
umount /mnt/ubuntu24 || true

echo "Unmount attempted (errors ignored)."