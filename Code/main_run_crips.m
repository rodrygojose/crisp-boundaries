
%% setup
% first cd to the directory containing this file, then run:
%compile; % this will check to make sure everything is compiled properly; if it is not, will try to compile it

type = 'speedy'; % use this for fastest results

%dataset = 'Aquarium-20';
%dataset = 'Hotel_bruges-19';
%dataset = 'Bousquet_car-16';
%dataset = 'Hotel_corner-10';
%dataset = 'Parthenay_oldChurch-25';
%dataset = 'Street-10';
%dataset = 'Street_soleil-15';
%dataset = 'Tree-18';
dataset = 'Yellowhouse-12';

data_root   = 'D:/D_workspace/datasets/0_mixed_renderer_datasets';
dataset_root= sprintf('%s/%s/IBR_data_VSFM-CMPMVS', data_root, dataset);
img_path    = sprintf('%s/half_size/', dataset_root);
img_dir     =  dir( img_path );
dataset_out = sprintf('%s/semantic/contours', dataset_root);

if ~exist(dataset_out, 'dir')
    mkdir(dataset_out);
end

if ~exist(sprintf('%s/crips', dataset_out), 'dir')
    mkdir(sprintf('%s/crips', dataset_out));
    mkdir(sprintf('%s/canny', dataset_out)) 
    mkdir(sprintf('%s/sobel', dataset_out))
end

%%

for i=1:size(img_dir, 1)
    
    img_name    = strcat(img_path, img_dir(i).name);
    img_id      = textscan(img_name, strcat(img_path,'%08d.jpg'));
    
    if( isempty(img_id{1}) )
        continue;
    end
    
    I = imread( img_name );
    
    % Detect boundaries
    % you can control the speed/accuracy tradeoff by setting 'type' to one of the values below
    % for more control, feel free to play with the parameters in setEnvironment.m
    
    [E_crips_d,~,~] = findBoundaries(I,type);
    
    % Other boundary detection methods
    
    I_gray = rgb2gray(I);
    E_canny = edge( I_gray, 'canny');
    E_sobel = edge( I_gray, 'sobel');
    E_crips = mat2gray(E_crips_d);
    
    % Saving images
    imwrite( imresize(E_crips, size(I(:,:,1))), sprintf('%s/crips/%s', dataset_out, img_dir(i).name));
    imwrite( E_canny, sprintf('%s/canny/%s', dataset_out, img_dir(i).name));
    imwrite( E_sobel, sprintf('%s/sobel/%s', dataset_out, img_dir(i).name));
    
end
