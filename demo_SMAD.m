clc;
clear all;
%load CASIA_test.mat
for cnt=1:1:400
    cnt
    imageName1=strcat(num2str(cnt),'.avi');   
    %imageName2=strcat('F:\smad_2020_1_10\SMAD_MTCNN\SPOOF\',imageName1);
    imageName2=strcat('C:\Users\user\Desktop\TIE_CODE\FMVD\',imageName1);
    xyloObj = VideoReader(imageName2);
    %获取视频信息（帧数，高度，宽度）
    nFrames = xyloObj.NumberOfFrames;
    vidHeight = xyloObj.Height;
    vidWidth = xyloObj.Width;
    % 先随机生成一个2维矩阵，double类型的
    data1=rand(vidHeight, vidWidth);
    %或者使用zeros函数,比较节省内存： data=zeros(vidHeight, vidWidth,'uint8');
    % 读取第k帧，转化为灰度图像，扩展为三维数组
    feat1=[];
    for k = 1:20
        imgdata=read(xyloObj,k);
        imgdata=double(rgb2gray(imgdata));
        feature=vsfm_feature(imgdata);
        feat1=[feat1 feature];
    end
   %spoof111_updated_SLBP_SMAD_6(cnt,:)=feat1;
   smad_vsfm_feature(cnt,:)=feat1;
end