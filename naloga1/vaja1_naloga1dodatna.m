#prva slika 350 px višina, oddaljeno 20 cm
#druga 280px 25 cm
#tretja 235 30 cm
#četrta 205 35 cm
#peta 178 40cm
#šesta 165 45cm
#IZRACUNANO V ZVEZKU
#
# y. = 350px
# Z = 200mm
# Y = 90 mm
# f = (y.*Z)/Y 
# f = 777.78
function naloga_f()
napake=[];
v_gimpu=[350,280,235,205,178,165]
arr_distances=[];
arr_pixels=[];
f=777.78;
distance = 200;
increment = 50;
obj_s = 90;
for i =1:6
  cur_pixels = (f*obj_s)/(distance+(increment*i));
  arr_distances(end+1)=distance+(increment*i);
  arr_pixels(end+1) =cur_pixels;
  napake(end+1)=abs(cur_pixels-v_gimpu(i));
 endfor
arr_distances;
arr_pixels
figure;
#naračunano v programu, izmerjeno v gimpu
plot(arr_distances,arr_pixels,arr_distances,v_gimpu);
napake
endfunction
naloga_f