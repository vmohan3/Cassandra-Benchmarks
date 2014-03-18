x = dlmread('clus_thread_write_thru.csv', '|')
clusters = [1,2,4,8]
clusters = clusters'
threads = [1,2,4,8,16,32,64,128,256]
threads = threads'

z = x(:,3)
z = reshape(z, 9, 4)

surf(clusters, threads, z)
set(gca, 'Xscale', 'log')
set(gca, 'Yscale', 'log')
set(gca, 'Zscale', 'linear')

set(gca, 'Xtick', clusters')
set(gca, 'Xticklabel', clusters')
xlabel('Number of machines in cluster')

set(gca, 'Ytick', threads')
set(gca, 'Yticklabel', threads')
ylabel('# client threads')

thru = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200]
set(gca, 'Ztick', thru)
set(gca, 'Zticklabel', thru)
zlabel('Throughput in MB/s')
title(' WRITE Throughput vs # Client Threads vs Cluster Size.  Value size = 1024 byte')


print -dpng clussize_thread_write_thru.png
