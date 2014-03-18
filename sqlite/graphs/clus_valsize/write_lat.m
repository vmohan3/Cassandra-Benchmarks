x = dlmread('clus_valsize_write_lat.csv', ',,')
clusters = [1,2,4,8]
clusters = clusters'
threads = [1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384]
threads = threads'

z = x(:,3)
z = reshape(z, 15, 4)

surf(clusters, threads, z)
set(gca, 'Xscale', 'log')
set(gca, 'Yscale', 'log')
set(gca, 'Zscale', 'linear')

set(gca, 'Xtick', clusters')
set(gca, 'Xticklabel', clusters')
xlabel('Number of machines in cluster')

set(gca, 'Ytick', threads')
set(gca, 'Yticklabel', threads')
ylabel('value size in bytes')

lat = [0,.10,.20,.30,.40,.50,.60,.70,.80,.90,1.00,1.10,1.20,1.30,1.40,1.50,1.60]
set(gca, 'Ztick', lat)
set(gca, 'Zticklabel', lat)
zlabel('latency per operation in ms')
title(' WRITE Latency vs # Value Size vs Cluster Size.  Client Threads = 32')

print -dpng clussize_valsize_write_lat.png
