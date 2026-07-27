#!/usr/bin/env python3
import gpiod
from gpiod.line import Direction, Value
import os
import time

# get fan 12v control line
fan_12v_config = {8: gpiod.LineSettings(direction=Direction.OUTPUT)}
fan_12v_line = gpiod.request_lines("/dev/gpiochip2", consumer="demo", config=fan_12v_config)

# search for max31760 from  /sys/class/hwmon/hwmon*/name
for hwmon in os.listdir("/sys/class/hwmon"):
    name = open(f"/sys/class/hwmon/{hwmon}/name").read().strip()
    if name == "max31760":
        max31760_controller_path = f"/sys/class/hwmon/{hwmon}"
        print(f"Found max31760 controller at {max31760_controller_path}")
        break
else:
    raise RuntimeError("max31760 controller not found")

pwm1_enable_fp = open(f"{max31760_controller_path}/pwm1_enable", "wb", buffering=0)
fan1_enable_fp = open(f"{max31760_controller_path}/fan1_enable", "wb", buffering=0)
fan1_fault_status_fp = open(f"{max31760_controller_path}/fan1_fault", "rb", buffering=0)
fan1_input_fp = open(f"{max31760_controller_path}/fan1_input", "rb", buffering=0)

# initialize fan control
fan1_enable_fp.write(b"0") # clear error status
fan1_enable_fp.seek(0)
fan_12v_line.set_value(8, Value.ACTIVE) # turn on 12v
pwm1_enable_fp.write(b"1") # manual mode
pwm1_enable_fp.seek(0)
fan1_enable_fp.write(b"1") # enable fan
fan1_enable_fp.seek(0)

while True:
    time.sleep(1)
    fan1_input = int(fan1_input_fp.read().decode().strip())
    fan1_input_fp.seek(0)
    fan1_fault_status = int(fan1_fault_status_fp.read().decode().strip())
    fan1_fault_status_fp.seek(0)
    print(f"Fan1 input: {fan1_input} RPM, fault status: {fan1_fault_status}")
    if fan1_fault_status != 0 or fan1_input < 100:
        print("Fan1 fault detected! Attempting to reset...")
        fan_12v_line.set_value(8, Value.INACTIVE) # turn off 12v
        fan1_enable_fp.write(b"0") # disable fan
        fan1_enable_fp.seek(0)
        time.sleep(10)
        fan_12v_line.set_value(8, Value.ACTIVE) # turn on 12v
        fan1_enable_fp.write(b"1") # enable fan
        fan1_enable_fp.seek(0)