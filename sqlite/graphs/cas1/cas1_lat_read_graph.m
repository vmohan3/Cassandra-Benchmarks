x = dlmread('cas1_lat_read.csv', ',')
threads = [1,2,4,8,16,32,64,128,256]
threads = threads'
val_len = [1,2,4,8,16,32,64,128,256,512,1024]
#val_len = [1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072]
val_len = val_len'

z = x(:,3)
z = reshape(z, 9, 11)

surf(val_len, threads, z)
set(gca, 'Xscale', 'log')
set(gca, 'Yscale', 'log')
set(gca, 'Zscale', 'linear')

set(gca, 'Xtick', val_len')
set(gca, 'Xticklabel', val_len')
xlabel('Value Size in bytes')

set(gca, 'Ytick', threads')
set(gca, 'Yticklabel', threads')
ylabel('# client threads')

lat = [0,.10,.20,.30,.40,.50,.60,.70,.80,.90,1.00,1.10,1.20,1.30,1.40,1.50,1.60]
set(gca, 'Ztick', lat)
set(gca, 'Zticklabel', lat)
zlabel('latency per operation in ms')
title('Single Node Cassandra READ Latency vs # Client Threads vs Value Size')

print -dpng cas1_lat_read.png
