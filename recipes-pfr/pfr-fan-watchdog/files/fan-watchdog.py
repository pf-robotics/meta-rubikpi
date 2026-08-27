#!/usr/bin/env python3
import gpiod
from gpiod.line import Direction, Value
import os
import time
import json

# del /tmp/host_status/fan12v_status.json if exists
if os.path.exists("/tmp/host_status/fan12v_status.json"):
    os.remove("/tmp/host_status/fan12v_status.json")

DEFAULT_PWM_VALUE = 128
MAX_ATTEMPTS = 3

# get fan 12v control line
try:
    fan_12v_config = {8: gpiod.LineSettings(direction=Direction.OUTPUT)}
    fan_12v_line = gpiod.request_lines("/dev/gpiochip2", consumer="fan-watchdog", config=fan_12v_config)
except Exception as e:
    json.dump({"error": True, "msg": f"failed to request fan 12v control line: {e}"}, open("/tmp/host_status/fan12v_status.json", "w"))
    raise RuntimeError(f"Failed to request fan 12v control line: {e}")

# search for max31760 from  /sys/class/hwmon/hwmon*/name
for hwmon in os.listdir("/sys/class/hwmon"):
    name = open(f"/sys/class/hwmon/{hwmon}/name").read().strip()
    if name == "max31760":
        max31760_controller_path = f"/sys/class/hwmon/{hwmon}"
        print(f"Found max31760 controller at {max31760_controller_path}")
        break
else:
    json.dump({"error": True, "msg": "max31760 controller not found"}, open("/tmp/host_status/fan12v_status.json", "w"))
    raise RuntimeError("max31760 controller not found")

pwm1_enable_fp = open(f"{max31760_controller_path}/pwm1_enable", "wb", buffering=0)
pwm1_value_fp = open(f"{max31760_controller_path}/pwm1", "wb", buffering=0)
fan1_enable_fp = open(f"{max31760_controller_path}/fan1_enable", "wb", buffering=0)
fan1_fault_status_fp = open(f"{max31760_controller_path}/fan1_fault", "rb", buffering=0)
fan1_input_fp = open(f"{max31760_controller_path}/fan1_input", "rb", buffering=0)

# initialize fan control
fan1_enable_fp.write(b"0") # clear error status
fan1_enable_fp.seek(0)
pwm1_enable_fp.write(b"1") # manual mode
pwm1_enable_fp.seek(0)
pwm1_value_fp.write(str(DEFAULT_PWM_VALUE).encode()) # set default pwm value
pwm1_value_fp.seek(0)
fan_12v_line.set_value(8, Value.ACTIVE) # turn on 12v
fan1_enable_fp.write(b"1") # enable fan
fan1_enable_fp.seek(0)

i = 0
while True:
    time.sleep(1)
    fan1_input = int(fan1_input_fp.read().decode().strip())
    fan1_input_fp.seek(0)
    fan1_fault_status = int(fan1_fault_status_fp.read().decode().strip())
    fan1_fault_status_fp.seek(0)
    print(f"Fan1 input: {fan1_input} RPM, fault status: {fan1_fault_status}")
    if fan1_fault_status != 0 or fan1_input < 100:
        print("Fan1 fault detected! Shuting down...")
        json.dump({"error": True, "fan1_input": fan1_input, "msg": "fan1 stucked", "attempt": i}, open("/tmp/host_status/fan12v_status.json", "w"))
        fan_12v_line.set_value(8, Value.INACTIVE) # turn off 12v
        fan1_enable_fp.write(b"0") # disable fan
        fan1_enable_fp.seek(0)
        if i >= MAX_ATTEMPTS:
            print("Max attempts reached. Exiting...")
            exit(-1)
        time.sleep(10)
        print("Attempting to restart fan...")
        fan_12v_line.set_value(8, Value.ACTIVE) # turn on 12v
        fan1_enable_fp.write(b"1") # enable fan
        fan1_enable_fp.seek(0)
        i += 1
    else:
        i = 0
        json.dump({"error": False, "fan1_input": fan1_input, "msg": "fan1 running", "attempt": i}, open("/tmp/host_status/fan12v_status.json", "w"))
