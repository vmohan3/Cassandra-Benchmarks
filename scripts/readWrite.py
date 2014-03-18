import os
import subprocess
from optparse import OptionParser
import datetime, time
import sys
import cql
import random

hostname = "localhost"
port = 9160
keyspace = "cas"
table = "keypairs";


def readXvalues(numReads, maxKey, sequential):
  con = cql.connect(hostname, port, keyspace)
  cursor = con.cursor()
  selectQuery = "SELECT key, value FROM {0} WHERE key={1}";

  keys = []

  i = 0
  while i < numReads:
    i = i + 1
    key = i
    if (sequential != 0):
      key = random.randint(0,maxKey+1)
    cursor.execute(selectQuery.format(table,key))
  
  cursor.close()
  con.close()

def insertXvalues(numVals, val_length, maxKey, sequential):
  #randomly generate values of val_length
  #insert them all in one batch

  con = cql.connect(hostname, port, keyspace)
  cursor = con.cursor()
  insertQuery = "INSERT INTO {0} (key, value) VALUES ({1}, {2})";
  i = 0
  while i < numVals:
    i = i + 1
    key = i; # currently sequential insert...randomly generate?
    if (sequential != 0):
      key = random.randint(0,maxKey+1)
    value = ''.join('Z' for x in range(val_length)) 
    cursor.execute(insertQuery.format(table, key, value));
  
  cursor.close()
  con.close()  

if __name__ =='__main__':


  usage = "Usage: %prog [options] <config file>"
  parser = OptionParser(usage=usage)


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
                    default="sequential", help="Specify sequential or random read/write",
                    metavar="#SEQUENTIAL")


  (options, args) = parser.parse_args()

  read_write = options.read_write
  num_vals = options.num
  value_len = options.values
  seq = options.sequential
  if seq == "sequential":
    is_sequential = 0
  elif seq == "random":
    is_sequential = 1
  else:
    print "seq specification error. input sequential or random"
  if (read_write == "read"):
    readXvalues(num_vals, num_vals * 1000, is_sequential)
  elif (read_write == "write"):
    insertXvalues(num_vals, value_len, num_vals * 1000, is_sequential)
  else:
    print "read_write argument '" + read_write + "' not recognized."
