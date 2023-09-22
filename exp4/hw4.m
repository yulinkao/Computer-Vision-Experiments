clc;
clear all;

load icp_xy.mat;

%?制原始?像
figure;
plot3(x(1,:),x(2,:),x(3,:),'b+');
hold on;
plot3(y(1,:),y(2,:),y(3,:),'r+');
hold off;

data_source=x;
data_target=y;

H_final=eye(4,4); %旋?矩?初始值
iteration=0;
Kf=H_final(1:3,1:3);
Hf=H_final(1:3,4);
data_target=Kf*data_target+Hf*ones(1,size(data_target,2)); %初次更新?集（代表粗配准?果）
err=1;
while(err>0.001)
iteration=iteration+1; %迭代次?
disp(['iteration=',num2str(iteration)]);

%利用?式距离找出???集
k=size(data_target,2);
for i = 1:k
data_q(1,:) = data_source(1,:) - data_target(1,i); % ???集中的?x坐?之差
data_q(2,:) = data_source(2,:) - data_target(2,i); % ???集中的?y坐?之差
data_q(3,:) = data_source(3,:) - data_target(3,i); % ???集中的?z坐?之差
distance = data_q(1,:).^2 + data_q(2,:).^2 + data_q(3,:).^2; % ?氏距离
[min_dis, min_index] = min(distance); % 找到距离最小的那??
data_mid(:,i) = data_source(:,min_index); % ?那??保存????
error(i) = min_dis; % 保存距离差值
end

%去中心化
data_target_mean=mean(data_target,2);
data_mid_mean=mean(data_mid,2);
data_target_c=data_target-data_target_mean*ones(1,size(data_target,2));
data_mid_c=data_mid-data_mid_mean*ones(1,size(data_mid,2));

%SVD分解
W=zeros(3,3);
for j=1:size(data_target_c,2)
    W=W+data_mid_c(:,j)*data_target_c(:,j)';
end
[U,S,V]=svd(W);
Kf=U*V';
Hf=data_mid_mean-Kf*data_target_mean;
err=mean(error);
H_t=[Kf,Hf];
H_t=[H_t;0,0,0,1];
H_final=H_t*H_final;%更新旋?矩?
disp(['err=',num2str(err)]);
disp('H=');
disp(H_final);
data_target=Kf*data_target+Hf*ones(1,size(data_target,2)); %更新?集
if iteration>=200
    break
end
end

figure;
plot3(data_source(1,:),data_source(2,:),data_source(3,:),'bx');
hold on;
plot3(data_target(1,:),data_target(2,:),data_target(3,:),'rx');
hold off;

R=H_final(1:3,1:3);
T=H_final(13:15);
T=T';

disp('H=');
disp(H_final);
disp('R=');
disp(R);
disp('T=');
disp(T);

