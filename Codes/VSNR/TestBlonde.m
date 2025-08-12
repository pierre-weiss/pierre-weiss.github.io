%% Blonde test
clear all;close all;
% Initializes the random number generator
rng(2);

% Loads and normalizes image
im=double(imread('Blonde.png'));
im=im/255;

% Adds noisy lines to the image
sigma=0.3;
imb=im;
[nx,ny,m]=size(im);
for i=1:nx
  imb(i,:,1)=im(i,:,1)+sigma*randn;
  imb(i,:,2)=im(i,:,2)+sigma*randn;
  imb(i,:,3)=im(i,:,3)+sigma*randn;
end

% Display
figure(1);image(uint8(255*imb));title('Noisy image')

% Defines the filter (a line)
Gabor=zeros(size(im));
alpha=1/size(im,1);
Gabor(1,:)=alpha;

% Denoising algorithm
x=im;
for i=1:3
  ub=imb(:,:,i); % Treats every components separately
  [y,Gap1,Primal1,Dual1,EstP1,EstD1]=Denoise_PD_StructuredNoise(ub,0,2,Gabor,100*alpha^2,1e-2,1000);
  x(:,:,i)=y;
end

% Display the result (sometimes she will have a sunburst)
figure(2);image(uint8(255*x));title('Denoised image');

disp(PSNR(im,imb))
disp(PSNR(im,x))

% imwrite(uint8(255*x),'BlondeDenoised.png')
% imwrite(uint8(255*imb),'BlondeNoisy.png')
% imwrite(uint8(255*im),'BlondeOriginal.png')
% 
% imwrite(uint8(255*x(150:300,150:300,:)),'BlondeDenoisedDetail.png')
% imwrite(uint8(255*imb(150:300,150:300,:)),'BlondeNoisyDetail.png')
% imwrite(uint8(255*im(150:300,150:300,:)),'BlondeOriginalDetail.png')