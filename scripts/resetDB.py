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

# init database cursor
con = cql.connect(hostname, port, keyspace)
cursor = con.cursor()

# get program arguments
usage = "Usage: %prog [options] <config file>"
parser = OptionParser(usage=usage)

parser.add_option("-n", "--num_records", type="int", dest="num_records", default=0, help="How many records should the database start with?", metavar="#NUMRECS")
  
parser.add_option("-v", "--val_len", type="int", dest="val_len", default=0, help="How large(bytes) should the values written to the DB be?", metavar="#NUMRECS")
(options, args) = parser.parse_args()

val_len = options.val_len
num_records = options.num_records

# perform DB reset

query = "TRUNCATE {0};"
cursor.execute(query.format(table)) # clear the table

# add new data
for i in range(0,num_records):
  query = "INSERT INTO {0} (key, value) VALUES ({1}, {2});"
  cursor.execute(query.format(table,i, ''.join('Z' for x in range(val_len))))

cursor.close()
con.close()
