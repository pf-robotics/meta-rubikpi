# rootfs
mkdir -p /mnt/ubuntu24
mount /root/ubuntu24.img /mnt/ubuntu24

# sys resources
mount -o bind /dev /mnt/ubuntu24/dev
mount -o bind /dev/shm /mnt/ubuntu24/dev/shm
mount -o bind /dev/pts /mnt/ubuntu24/dev/pts
mount -o bind /sys /mnt/ubuntu24/sys
mount -o bind /proc /mnt/ubuntu24/proc
mount -o bind /tmp /mnt/ubuntu24/tmp

# configs
mkdir -p /opt/pfr /mnt/ubuntu24/opt/pfr
mount -o bind /opt/pfr /mnt/ubuntu24/opt/pfr
mkdir -p /var/cache/camera /mnt/ubuntu24/var/cache/camera
mount -o bind /var/cache/camera /mnt/ubuntu24/var/cache/camera
# libs
touch /mnt/ubuntu24/usr/lib/libadreno_utils.so.1
mount -o bind /usr/lib/libadreno_utils.so.1 /mnt/ubuntu24/usr/lib/libadreno_utils.so.1
#touch /mnt/ubuntu24/usr/lib/libCB.so.1
#mount -o bind /usr/lib/libCB.so.1 /mnt/ubuntu24/usr/lib/libCB.so.1
touch /mnt/ubuntu24/usr/lib/libCB.so
mount -o bind /usr/lib/libCB.so.1 /mnt/ubuntu24/usr/lib/libCB.so
touch /mnt/ubuntu24/usr/lib/libcdsprpc.so
mount -o bind /usr/lib/libcdsprpc.so /mnt/ubuntu24/usr/lib/libcdsprpc.so
touch /mnt/ubuntu24/usr/lib/libdmabufheap.so.0
mount -o bind /usr/lib/libdmabufheap.so.0 /mnt/ubuntu24/usr/lib/libdmabufheap.so.0
#touch /mnt/ubuntu24/usr/lib/libgsl.so.1
#mount -o bind /usr/lib/libgsl.so.1 /mnt/ubuntu24/usr/lib/libgsl.so.1
touch /mnt/ubuntu24/usr/lib/libgsl.so
mount -o bind /usr/lib/libgsl.so.1 /mnt/ubuntu24/usr/lib/libgsl.so
#touch /mnt/ubuntu24/usr/lib/libllvm-qcom.so.1
#mount -o bind /usr/lib/libllvm-qcom.so.1 /mnt/ubuntu24/usr/lib/libllvm-qcom.so.1
touch /mnt/ubuntu24/usr/lib/libllvm-qcom.so
mount -o bind /usr/lib/libllvm-qcom.so.1 /mnt/ubuntu24/usr/lib/libllvm-qcom.so
#touch /mnt/ubuntu24/usr/lib/libOpenCL.so.1
#mount -o bind /usr/lib/libOpenCL.so.1 /mnt/ubuntu24/usr/lib/libOpenCL.so.1
touch /mnt/ubuntu24/usr/lib/libOpenCL.so
mount -o bind /usr/lib/libOpenCL.so.1 /mnt/ubuntu24/usr/lib/libOpenCL.so
#touch /mnt/ubuntu24/usr/lib/libOpenCL_adreno.so.1
#mount -o bind /usr/lib/libOpenCL_adreno.so.1 /mnt/ubuntu24/usr/lib/libOpenCL_adreno.so.1
touch /mnt/ubuntu24/usr/lib/libOpenCL_adreno.so
mount -o bind /usr/lib/libOpenCL_adreno.so.1 /mnt/ubuntu24/usr/lib/libOpenCL_adreno.so
touch /mnt/ubuntu24/usr/lib/libpropertyvault.so.0
mount -o bind /usr/lib/libpropertyvault.so.0 /mnt/ubuntu24/usr/lib/libpropertyvault.so.0
mkdir -p /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/gstreamer-1.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/gstreamer-1.0/libgstqtiqmmfsrc.so
mount -o bind /usr/lib/gstreamer-1.0/libgstqtiqmmfsrc.so /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/gstreamer-1.0/libgstqtiqmmfsrc.so
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libcamera_metadata.so
mount -o bind /usr/lib/libcamera_metadata.so /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libcamera_metadata.so
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libcamera_metadata.so.0
mount -o bind /usr/lib/libcamera_metadata.so.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libcamera_metadata.so.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libcamera_metadata.so.0.1.0
mount -o bind /usr/lib/libcamera_metadata.so.0.1.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libcamera_metadata.so.0.1.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_recorder_client.so
mount -o bind /usr/lib/libqmmf_recorder_client.so /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_recorder_client.so
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_recorder_client.so.1
mount -o bind /usr/lib/libqmmf_recorder_client.so.1 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_recorder_client.so.1
#touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_recorder_client.so.1.0
#mount -o bind /usr/lib/libqmmf_recorder_client.so.1.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_recorder_client.so.1.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_camera_metadata.so
mount -o bind /usr/lib/libqmmf_camera_metadata.so /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_camera_metadata.so
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_camera_metadata.so.1
mount -o bind /usr/lib/libqmmf_camera_metadata.so.1 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_camera_metadata.so.1
#touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_camera_metadata.so.1.0
#mount -o bind /usr/lib/libqmmf_camera_metadata.so.1.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_camera_metadata.so.1.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libgstqtivideobase.so
mount -o bind /usr/lib/libgstqtivideobase.so /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libgstqtivideobase.so
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libgstqtivideobase.so.1
mount -o bind /usr/lib/libgstqtivideobase.so.1 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libgstqtivideobase.so.1
#touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libgstqtivideobase.so.1.0.0
#mount -o bind /usr/lib/libgstqtivideobase.so.1.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libgstqtivideobase.so.1.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_propertyvault.so
mount -o bind /usr/lib/libqmmf_propertyvault.so /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_propertyvault.so
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_proto.so
mount -o bind /usr/lib/libqmmf_proto.so /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_proto.so
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_proto.so.1
mount -o bind /usr/lib/libqmmf_proto.so.1 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_proto.so.1
#touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_proto.so.1.0
#mount -o bind /usr/lib/libqmmf_proto.so.1.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_proto.so.1.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_utils.so
mount -o bind /usr/lib/libqmmf_utils.so /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_utils.so
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_utils.so.1
mount -o bind /usr/lib/libqmmf_utils.so.1 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_utils.so.1
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_utils.so.1.0
mount -o bind /usr/lib/libqmmf_utils.so.1.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libqmmf_utils.so.1.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libgstqtiallocatorsbase.so
mount -o bind /usr/lib/libgstqtiallocatorsbase.so /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libgstqtiallocatorsbase.so
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libgstqtiallocatorsbase.so.1
mount -o bind /usr/lib/libgstqtiallocatorsbase.so.1 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libgstqtiallocatorsbase.so.1
#touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libgstqtiallocatorsbase.so.1.0.0
#mount -o bind /usr/lib/libgstqtiallocatorsbase.so.1.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libgstqtiallocatorsbase.so.1.0.0
#touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libprotobuf.so.30
#mount -o bind /usr/lib/libprotobuf.so.30 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libprotobuf.so.30
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libprotobuf.so.25.3.0
mount -o bind /usr/lib/libprotobuf.so.25.3.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libprotobuf.so.25.3.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_check_op.so.2401.0.0
mount -o bind /usr/lib/libabsl_log_internal_check_op.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_check_op.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_message.so.2401.0.0
mount -o bind /usr/lib/libabsl_log_internal_message.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_message.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_die_if_null.so.2401.0.0
mount -o bind /usr/lib/libabsl_die_if_null.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_die_if_null.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_statusor.so.2401.0.0
mount -o bind /usr/lib/libabsl_statusor.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_statusor.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_conditions.so.2401.0.0
mount -o bind /usr/lib/libabsl_log_internal_conditions.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_conditions.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_nullguard.so.2401.0.0
mount -o bind /usr/lib/libabsl_log_internal_nullguard.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_nullguard.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_raw_hash_set.so.2401.0.0
mount -o bind /usr/lib/libabsl_raw_hash_set.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_raw_hash_set.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_hash.so.2401.0.0
mount -o bind /usr/lib/libabsl_hash.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_hash.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_status.so.2401.0.0
mount -o bind /usr/lib/libabsl_status.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_status.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_cord.so.2401.0.0
mount -o bind /usr/lib/libabsl_cord.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_cord.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_cordz_info.so.2401.0.0
mount -o bind /usr/lib/libabsl_cordz_info.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_cordz_info.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_synchronization.so.2401.0.0
mount -o bind /usr/lib/libabsl_synchronization.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_synchronization.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_time.so.2401.0.0
mount -o bind /usr/lib/libabsl_time.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_time.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_time_zone.so.2401.0.0
mount -o bind /usr/lib/libabsl_time_zone.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_time_zone.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_str_format_internal.so.2401.0.0
mount -o bind /usr/lib/libabsl_str_format_internal.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_str_format_internal.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_strings.so.2401.0.0
mount -o bind /usr/lib/libabsl_strings.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_strings.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_spinlock_wait.so.2401.0.0
mount -o bind /usr/lib/libabsl_spinlock_wait.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_spinlock_wait.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_throw_delegate.so.2401.0.0
mount -o bind /usr/lib/libabsl_throw_delegate.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_throw_delegate.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_raw_logging_internal.so.2401.0.0
mount -o bind /usr/lib/libabsl_raw_logging_internal.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_raw_logging_internal.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_examine_stack.so.2401.0.0
mount -o bind /usr/lib/libabsl_examine_stack.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_examine_stack.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_format.so.2401.0.0
mount -o bind /usr/lib/libabsl_log_internal_format.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_format.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_proto.so.2401.0.0
mount -o bind /usr/lib/libabsl_log_internal_proto.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_proto.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_strerror.so.2401.0.0
mount -o bind /usr/lib/libabsl_strerror.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_strerror.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_log_sink_set.so.2401.0.0
mount -o bind /usr/lib/libabsl_log_internal_log_sink_set.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_log_sink_set.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_globals.so.2401.0.0
mount -o bind /usr/lib/libabsl_log_internal_globals.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_internal_globals.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_globals.so.2401.0.0
mount -o bind /usr/lib/libabsl_log_globals.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_globals.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_base.so.2401.0.0
mount -o bind /usr/lib/libabsl_base.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_base.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_city.so.2401.0.0
mount -o bind /usr/lib/libabsl_city.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_city.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_low_level_hash.so.2401.0.0
mount -o bind /usr/lib/libabsl_low_level_hash.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_low_level_hash.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_cord_internal.so.2401.0.0
mount -o bind /usr/lib/libabsl_cord_internal.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_cord_internal.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_crc_cord_state.so.2401.0.0
mount -o bind /usr/lib/libabsl_crc_cord_state.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_crc_cord_state.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_cordz_functions.so.2401.0.0
mount -o bind /usr/lib/libabsl_cordz_functions.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_cordz_functions.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_cordz_handle.so.2401.0.0
mount -o bind /usr/lib/libabsl_cordz_handle.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_cordz_handle.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_stacktrace.so.2401.0.0
mount -o bind /usr/lib/libabsl_stacktrace.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_stacktrace.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_graphcycles_internal.so.2401.0.0
mount -o bind /usr/lib/libabsl_graphcycles_internal.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_graphcycles_internal.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_kernel_timeout_internal.so.2401.0.0
mount -o bind /usr/lib/libabsl_kernel_timeout_internal.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_kernel_timeout_internal.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_symbolize.so.2401.0.0
mount -o bind /usr/lib/libabsl_symbolize.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_symbolize.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_malloc_internal.so.2401.0.0
mount -o bind /usr/lib/libabsl_malloc_internal.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_malloc_internal.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_int128.so.2401.0.0
mount -o bind /usr/lib/libabsl_int128.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_int128.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_strings_internal.so.2401.0.0
mount -o bind /usr/lib/libabsl_strings_internal.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_strings_internal.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_sink.so.2401.0.0
mount -o bind /usr/lib/libabsl_log_sink.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_log_sink.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_crc32c.so.2401.0.0
mount -o bind /usr/lib/libabsl_crc32c.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_crc32c.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_exponential_biased.so.2401.0.0
mount -o bind /usr/lib/libabsl_exponential_biased.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_exponential_biased.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_debugging_internal.so.2401.0.0
mount -o bind /usr/lib/libabsl_debugging_internal.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_debugging_internal.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_demangle_internal.so.2401.0.0
mount -o bind /usr/lib/libabsl_demangle_internal.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_demangle_internal.so.2401.0.0
touch /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_crc_internal.so.2401.0.0
mount -o bind /usr/lib/libabsl_crc_internal.so.2401.0.0 /mnt/ubuntu24/usr/lib/aarch64-linux-gnu/libabsl_crc_internal.so.2401.0.0