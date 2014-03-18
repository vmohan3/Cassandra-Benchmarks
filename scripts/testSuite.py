import os
import subprocess
import sys


cmd = "python runBench2.py --threads {0} --readwrite {1} --N 100000 --values {2} --sequential random --existing {3}"

val_len = 2048
while val_len <= 65336:

  threads = 1
  while threads <= 256:
    
    read_cmd = cmd.format(threads, "read", val_len, "10000")
    print read_cmd
    print subprocess.Popen(read_cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT).stdout.read()

    write_cmd = cmd.format(threads, "write", val_len, "0")
    print write_cmd
    print subprocess.Popen(write_cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT).stdout.read()

    threads *= 2
  
  val_len *= 2
