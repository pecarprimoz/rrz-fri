## NALOGA 3 
 pkg load image
# b)
# umbrella_m = double(rgb2gray(imread("umbrellas.jpg")));
# umbrella_v = umbrella_m(:);
# figure(1); clf;
# bins = 10;
# umbrella_hist  = hist(umbrella_v, bins); subplot(1,3,1);  bar(umbrella_hist,'r');
# bins = 20;
# umbrella_hist  = hist(umbrella_v, bins); subplot(1,3,2); bar(umbrella_hist,'g');
# bins = 40;
# umbrella_hist  = hist(umbrella_v, bins); subplot(1,3,3); bar(umbrella_hist,'r');

###
#c)
# help bar
# implementacija imgstretch funkcije
 cur_matrix = double(imread("phone.jpg"));
 function histstretch(I)
 cur_vector = I(:);
 max_vec=max(cur_vector);
 min_vec=min(cur_vector);
 dist_between = max_vec-min_vec;
 figure(1);
 subplot(2,2,1); imshow(uint8(I));
 subplot(2,2,2); I_hist = hist(cur_vector,0:256); bar(I_hist);
 #Zamaknemo na začetek 
 mat_stretch=(I-min_vec)*(256/dist_between);
 subplot(2, 2,3); imshow(uint8(mat_stretch));
 subplot(2, 2,4); mat_stretch_hist = hist(mat_stretch(:),0:256); bar(mat_stretch_hist);
 end
histstretch(cur_matrix);
 
## konec implementacije
# ker vrednosti porazdelimo po celotnem histogramu, namesto da je na nekem fiksnem
# območju (min, max)
# sprememba kontrasta?

#d )
#telefon je že v grayscale
function d()
 phone_img = imread("phone.jpg");
 figure(2);
 subplot(1,3,1); imshow(phone_img);
 tobw = im2bw(phone_img);
 bw_hist = tobw(:);
 subplot(1,3,2); phone_hist = hist(phone_img(:),0:256); bar(phone_hist,'r');
 subplot(1,3,3); imshow(tobw);
 end
 d
#Otsujeva metoda e dobra takrat ko imamo na histogramu velike skoke v vredhostih
#ta jih zna popraviti, torej dela na slikah ki imajo nekje prisotne samo črne barve
#in nekje samo bele