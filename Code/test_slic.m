close all;
run('C:\Users\rortizca\workspace\useful_code\vlfeat-0.9.20\toolbox\vl_setup')

addpath(genpath('C:\Users\rortizca\workspace\ibr-common\src\utilities\scripts\scripts_plane_estimation'));

addpath(genpath('C:\Users\rortizca\workspace\useful_code\crisp-boundaries'))

%%

ID = 8;
dataset = 'D:\D_workspace\datasets\0_debuging\und_coffebreak\IBR_data_VSFM-CMPMVS';
I = imread( sprintf('%s/half_size/%08d.jpg', dataset, ID) );

%%


type = 'speedy'; % use this for fastest results

[E,E_oriented] = findBoundaries(I,type);

%close all; subplot(121); imshow(I); subplot(122); imshow(1-mat2gray(E));
figure; subplot(121); imshow(I); subplot(122); imshow(1-mat2gray(E));


%%
n       = 1500;
[h,w,~] = size(I);

regionSize = sqrt(w*h/n);
regularizer= 10;

% img = imrotate(flip(I,2), 90);
% 
% imlab   = vl_xyz2lab(vl_rgb2xyz(img)) ;
% %seg_rot = vl_slic(single(imlab), regionSize, regularizer) ;
% seg_rot = vl_slic(single(img), regionSize, regularizer) ;
% 
% segments = flip( imrotate(seg_rot, -90) ,2);
% figure; imagesc(segments)
% 
% max(max(segments))

%%

maxdist     = 30;
ratio       = 0.5;
kernelsize  = 2;
[Iseg, segs, map, gaps, dens_estim] = vl_quickseg(I, ratio, kernelsize, maxdist);
figure; imagesc(Iseg);
figure; imagesc(segs);
figure; imagesc(dens_estim);


%%
spimg = read_spixels(sprintf('%s/superpixels/%08d.sp', dataset, ID) );
figure; imagesc(spimg)

max(max(spimg))


%%
