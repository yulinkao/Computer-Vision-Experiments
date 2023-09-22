clc;
clear all;

img1=im2double(imread('testcalenphoto_01.jpg'))
img2=im2double(imread('testcalenphoto_04.jpg'))
img3=im2double(imread('testcalenphoto_05.jpg'))

k1=0.2063;
k2=-0.6652;
k3=0.00305;
k4=0.00207;
k5=0;

[m,n,p] = size(img1);
res = zeros(m,n,p);

for i=1:m
    for j=1:n
        x = (i/m-0.5);
        y = (i/n-0.5);
        r = x^2 + y^2;
        t = 1 + k1*r + k2*r^2 + k5*r^3;
        u = round(t*i + 2*k3*x*y + k4*(r+2*x^2));
        v = round(t*j + 2*k4*x*y + k3*(r+2*y^2));
        if 1<=u && u<=m && 1<=v && v<=n
            res(i,j,:) = img1(u,v,:);
        end
    end
end

[m,n,p] = size(img2);
res = zeros(m,n,p);

for i=1:m
    for j=1:n
        x = (i/m-0.5);
        y = (i/n-0.5);
        r = x^2 + y^2;
        t = 1 + k1*r + k2*r^2 + k5*r^3;
        u = round(t*i + 2*k3*x*y + k4*(r+2*x^2));
        v = round(t*j + 2*k4*x*y + k3*(r+2*y^2));
        if 1<=u && u<=m && 1<=v && v<=n
            res(i,j,:) = img2(u,v,:);
        end
    end
end

[m,n,p] = size(img3);
res = zeros(m,n,p);

for i=1:m
    for j=1:n
        x = (i/m-0.5);
        y = (i/n-0.5);
        r = x^2 + y^2;
        t = 1 + k1*r + k2*r^2 + k5*r^3;
        u = round(t*i + 2*k3*x*y + k4*(r+2*x^2));
        v = round(t*j + 2*k4*x*y + k3*(r+2*y^2));
        if 1<=u && u<=m && 1<=v && v<=n
            res(i,j,:) = img3(u,v,:);
        end
    end
end

figure;
omg1=imshow(img1);hold on;
figure;
title(img2);
omg2=imshow(img2);hold on;
figure;
omg3=imshow(img3);


