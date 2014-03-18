x = dlmread('cas8_thru_read.csv', ',')
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

time = [0,20,40,60,80,100,120,140,160,180,200,220,240,260,280,300,320,340,360,380,400]
set(gca, 'Ztick', time)
set(gca, 'Zticklabel', time)
zlabel('Through-put in MB/s')

title('8 Node Cassandra READ Through-put vs # Client Threads vs Value Size')


print -dpng cas8_thru_read.png
