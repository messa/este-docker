#!/usr/bin/env python2

import signal
import subprocess
import sys
from time import sleep

stop = False


def handler(signum, frame):
    global stop
    stop = True

signal.signal(signal.SIGTERM, handler)
signal.signal(signal.SIGINT, handler)

args = sys.argv[1:]

p = subprocess.Popen(args)

while not stop and p.poll() is None:
    sleep(.1)

try:
    p.terminate()
    p.wait()
except OSError:
    pass  # no such process... that's ok

sys.exit(p.returncode)
