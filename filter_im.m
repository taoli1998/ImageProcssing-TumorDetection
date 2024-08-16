
function [Gaussian_Image]=filter_im(im,D0,A) 

N=size(im);
p=2*N(1)-1;
q=2*N(2)-1;
zero_padding=zeros(p,q);
zero_padding(1:N(1),1:N(2))=im;
x=repmat([1:q],p,1);
y=repmat([1:p]',1,q);
x_center=x-(q+1)/2;
y_center=y-(p+1)/2;
f_xy=(-1).^(x_center+y_center).*zero_padding;
fourier_image = fft2(f_xy);

%create the filter parameters

r=sqrt((p/2)^2+(q/2)^2);
% D0=cutOffFreq/pi*r;
D=sqrt(x_center.^2+y_center.^2);%diameter of LPF circle 

%create and apply gaussian LPF

H_Gaussian=exp(-D.^2/(2*D0^2));%gaussian transfer function
fourier_Gaussian=fourier_image.*H_Gaussian;
g_image=real(ifft2(fourier_Gaussian));
Gaussian_Image=uint8(g_image.*(-1).^(x_center+y_center));%
Gaussian_Image=Gaussian_Image(1:N(1),1:N(2));

end


