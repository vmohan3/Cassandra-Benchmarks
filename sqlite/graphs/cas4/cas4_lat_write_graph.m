x = dlmread('cas4_lat_write.csv', ',')
threads = [1,2,4,8,16,32,64,128,256]
threads = threads'
#val_len = [1,2,4,8,16,32,64,128,256,512,1024]
val_len = [1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536]
val_len = val_len'

z = x(:,3)
z = reshape(z, 9, 17)

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
lat = [0, .8, 1.6, 2.4, 3.2, 4.0, 4.8, 5.6, 6.4, 7.2,8.0,8.8,9.6,10.4,11.2]
set(gca, 'Ztick', lat)
set(gca, 'Zticklabel', lat)
zlabel('latency per operation in ms')
title('4 Node Cassandra WRITE Latency vs # Client Threads vs Value Size')


print -dpng cas4_lat_write.png

