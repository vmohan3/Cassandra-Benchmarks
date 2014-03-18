x = dlmread('out.csv', ',')
threads = [1,2,4,8,16,32,64,128,256]
threads = threads'
val_len = [1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,65536,131072]
val_len = val_len'

z = x(:,3)
z = reshape(z, 9, 18)

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

time = [0,10,20,30,40,50,60,70,80,90,100,110,120]
set(gca, 'Ztick', time)
set(gca, 'Zticklabel', time)
zlabel('execution time')


