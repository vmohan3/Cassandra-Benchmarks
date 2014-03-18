import os
import subprocess
from optparse import OptionParser
import datetime, time
import sys
import cql

servers = ["localhost"] 
num_servers = 1

def recordResults(nr, rw, val_len, seq, num_servers, num_t, num_c, num_er, time, num_p, cr_acc):
  with open("results.csv", "a") as rfile:
    rfile.write("{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}, {8}, {9}, {10}\n".format(nr, rw, val_len, seq, num_servers, num_t, num_c, num_er, time, num_p, cr_acc))

if __name__ =='__main__':


  usage = "Usage: %prog [options] <config file>"
  parser = OptionParser(usage=usage)

  parser.add_option("-t", "--threads", type="int", dest="num_threads",
                    default=2, help="specify the number of instances of readWrite.py to execute",
                    metavar="#NUMTHREAD")

  parser.add_option("-r", "--readwrite", type="string", dest="read_write",
                    default="read", help="specify whether this is a read or write benchmark",
                    metavar="#RW")
  
  parser.add_option("-n", "--N", type="int", dest="num",
                    default=1000, help="specify the number of values to read/write",
                    metavar="#NUM")

  parser.add_option("-v", "--values", type="int", dest="values",
                    default=0, help="blank/empty, specified size of a random input value",
                    metavar="#VALUES")

  parser.add_option("-s", "--sequential", type="string", dest="sequential",
                    default="sequential", help="Specify 0 for sequential and 1 for random read/write",
                    metavar="#SEQUENTIAL")

  parser.add_option("-e", "--existing", type="int", dest="num_exist",
                    default=1000, help="Specify number of existing rows in database",
                    metavar="#EXIST")


  
  (options, args) = parser.parse_args()
  threads = options.num_threads
  rw = options.read_write
  num_vals = options.num
  val_len = options.values
  seq = options.sequential 

  num_existing_rows = options.num_exist
 
  #run resetDB script
  cmd = "python resetDB.py -n {0} -v {1}".format(num_existing_rows, val_len)
  print cmd
  print subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT).stdout.read()

  num_servers = 1
  num_client_machines = 1
  num_net_partitions = 0
  col_or_row_access = "row"

  
  beg_timestamp = datetime.datetime.now()

  cmd = "python /home/ubuntu/scripts/readWrite.py -r {0} -n {1} -v {2} -s {3}".format(rw, num_vals / threads, val_len, seq)
  procs = []

  
  
  for x in range(threads):
    cur_server = servers[x % num_servers]
    fin_cmd = "ssh -i /home/ubuntu/.ssh/assign1.pem {0} '{1}'".format(cur_server, cmd)
    print fin_cmd
    ret = subprocess.Popen(fin_cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    procs.append(ret)

  #wait for subprocesses to finish
  for proc in procs:
    print proc.stdout.read()

  fin_timestamp = datetime.datetime.now()

  print beg_timestamp
  print fin_timestamp
  ex_time = fin_timestamp - beg_timestamp
  print ex_time
  recordResults(num_vals, rw, val_len, seq, num_servers, threads, num_client_machines, num_existing_rows, ex_time, num_net_partitions, col_or_row_access)


