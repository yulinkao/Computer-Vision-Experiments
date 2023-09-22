clc;
clear all;

% Load images
I1=im2double(imread('testcalenphoto_01.jpg'));
I2=im2double(imread('testcalenphoto_05.jpg'));

% Get the Key Points
Options.upright=true;
Options.tresh=0.0001;
Ipts1=OpenSurf(I1,Options);
Ipts2=OpenSurf(I2,Options);

% Put the landmark descriptors in a matrix
D1 = reshape([Ipts1.descriptor],64,[]);
D2 = reshape([Ipts2.descriptor],64,[]);

% Find the best matches
err=zeros(1,length(Ipts1));
cor1=1:length(Ipts1);
cor2=zeros(1,length(Ipts1));
for i=1:length(Ipts1)
    distance=sum((D2-repmat(D1(:,i),[1 length(Ipts2)])).^2,1);
    [err(i),cor2(i)]=min(distance);
end

% Sort matches on vector distance
[~, ind]=sort(err);
cor1=cor1(ind);
cor2=cor2(ind);

% Make vectors with the coordinates of the best matches
Pos1=[[Ipts1(cor1).y]',[Ipts1(cor1).x]'];
Pos2=[[Ipts2(cor2).y]',[Ipts2(cor2).x]'];
Pos1=Pos1(1:30,:);
Pos2=Pos2(1:30,:);

x=Pos1;
y=Pos2;
k=100;
th=500;

[m,~] = size(x);
best = 0;
res = [];

for t=1:k
    ch = randperm(30,3);
    A = [y(ch(1),:),1,0,0,0;
         0,0,0,y(ch(1),:),1;
         y(ch(2),:),1,0,0,0;
         0,0,0,y(ch(2),:),1;
         y(ch(3),:),1,0,0,0;
         0,0,0,y(ch(3),:),1];
    B = [x(ch(1),:),x(ch(2),:),x(ch(3),:)]';
    M = A\B;
    M = [M(1:3)';M(4:6)'];
    l = 0;
    tmp = [];
    for i=1:m
        a = (M * [y(i,:),1]')';
        d = sum((a-x(i,:)).^2);
        if d<th
            l = l+1;
            tmp = [tmp i];
        end
    end
    if l>best
        best = l;
        res = tmp;
    end
end

rx = zeros(best,2);
ry = zeros(best,2);
for i=1:best
    rx(i,:) = x(res(i),:);
    ry(i,:) = y(res(i),:);
end

a=rx;
b=ry;
c=50;

[m,~] = size(a);
Fs = zeros(3,3,c);
for t=1:c
    ch = randperm(m,8);
    A = zeros(8,9);
    for i=1:8
        A(i,1) = b(ch(i),1) * a(ch(i),1);
        A(i,2) = b(ch(i),1) * a(ch(i),2);
        A(i,3) = b(ch(i),1);
        A(i,4) = b(ch(i),2) * a(ch(i),1);
        A(i,5) = b(ch(i),2) * a(ch(i),2);
        A(i,6) = b(ch(i),2);
        A(i,7) = a(ch(i),1);
        A(i,8) = a(ch(i),2);
        A(i,9) = 1;
    end
    [~,~,V] = svd(A);
    Fs(:,:,t) = [V(1:3,9)';V(4:6,9)';V(7:9,9)'];
end

F = mean(Fs,3);

