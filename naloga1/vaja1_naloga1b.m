t=30;
c=1;
arr_time=[];
arr_distances=[];
arr_sizes=[];
cur_s=10;
f=0.01;
X=2.5;
car_size=0;
while(c<t)
  arr_time(end+1) = c;
  arr_distances(end+1) = cur_s;
  car_size=f*(X/cur_s);
  arr_sizes(end+1)=car_size;
  new_s=(1/2)*(0.5)*c^2;
  cur_s+=new_s;
  c++;
endwhile

arr_distances;
arr_sizes;
figure;
plot(arr_time,arr_sizes);

figure;
plot(arr_distances,arr_sizes);

# TODO, nared 10x na sekundo sample rate, sicer se nebo nic spremenil