x = dlmread('clus_valsize_read_thru.csv', ',')
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
ylabel('Value Size in bytes')

thru = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200]
set(gca, 'Ztick', thru)
set(gca, 'Zticklabel', thru)
zlabel('Throughput in MB/s')
title(' READ Throughput vs # Value Size vs Cluster Size.  Client Threads = 32')

print -dpng clussize_valsize_read_thru.png
