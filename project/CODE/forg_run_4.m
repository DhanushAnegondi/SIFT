clc;
clear all;
close all
cd images
[J P]=uigetfile('*.*','select the source Image');
Q=imread(strcat(P,J));
cd ..
figure,imshow(Q);title('original image');
Q=Q(1:4:end,1:4:end,:);
[M N Z]=size(Q);
I1=Q(:,:,1);
nstr=strcat(J(1:end-4),'_copy.png');
cd images
Q1=imread(nstr);
figure,imshow(Q1),title('forged image');
Q1=Q1(1:4:end,1:4:end,:);
cd ..
%==========================================
I=Q1(:,:,1);
% perform adapive block size determination 
[a1,b1,c1,d1]=dwt2(I,'haar');
[a2,b2,c2,d2]=dwt2(a1,'haar');
[a3,b3,c3,d3]=dwt2(a2,'haar');
[a4,b4,c4,d4]=dwt2(a3,'haar');
Elf=sum(sum(a4));
A1=sum(sum(b1));A2=sum(sum(c1));A3=sum(sum(d1));
B1=sum(sum(b2));B2=sum(sum(c2));B3=sum(sum(d2));
C1=sum(sum(b3));C2=sum(sum(c3));C3=sum(sum(d3));
D1=sum(sum(b4));D2=sum(sum(c4));D3=sum(sum(d4));
EHF=A1+A2+A3+B1+B2+B3+C1+C2+C3+D1+D2+D3;
PLF=Elf/(Elf+EHF)*100;
if PLF<=20
    S=sqrt(0.01*M*N);
else
   S=sqrt(0.02*M*N);
end
[L,N]=superpixels(Q1,ceil(S));
BW = boundarymask(L);
figure,imshow(imoverlay(uint8(Q1),BW,'red'))
%==========================================
t=1;
for ii=1:N
    G=zeros(size(L));
    D=find(L==ii);
    G(D)=1;
    Fimg=double(I).*G;
    F2=double(I1).*G;
    DF{ii}=Fimg-F2;
%     figure,imshow(DF{ii},[]);
    [image,descriptors,locs] = sift(uint8(Fimg));
    if numel(locs)~=0
        if size(locs,1)>=4
        C{t}=ceil(locs(1:4,1:2));
        else
       C{t}=ceil(locs(1:size(locs,1),1:2));       
        end
    t=t+1;
    end
end
k=1;p=1;

for ii=2:t-1
for tt=1:t-1
if k~=ii
    A=C{ii}(:);
    na=numel(A);
    B=C{tt}(:);nb=numel(B);  
    if na>nb
        B(nb:na)=0;
    else
        A(na:nb)=0;
    end    
xx=corrcoef(A,B);
CC(p)=xx(2);
pr{p}=[ii,tt];
p=p+1;
end
end
k=k+1;
end
k=1;Tp=2;
tm1=zeros(size(I));
for ii=1:t-1
    A=C{ii};
    DS=sum(sum(dist(A',A)));
    for jj=1:t-1
        if ii~=jj
            B=C{jj};
            DD=sum(sum(dist(A',B)));           
            if Tp<=DS./DD
                INDX{ii}=B;
                dx(ii)=k;
            end            
        end
    end   
    if abs(sum(sum(DF{ii})))>Tp
        tm1=tm1+DF{ii};
    end
end
    
%=========================
ccas=sort(abs(CC));
fds=gradient(ccas);
sdf=gradient(fds);
mfds=mean(fds);
dx=find(sdf>mfds);
lsds=CC(dx);
Trb=min(lsds);
dxc=find(CC>abs(Trb));
tm=zeros(size(I));
 for ii=1:length(dxc)
    [yy]=pr{dxc(ii)};
     b1=yy(1);b2=yy(2);
     BB1=floor(C{b1});BB2=floor(C{b2});
     tm(BB1(:,1),BB1(:,2))=1;
     tm(BB2(:,1),BB2(:,2))=1;
%      clear BB1 BB2
end
p=1;
for ii=1:length(dxc)
    [yy]=pr{dxc(ii)};
    b1=yy(1);b2=yy(2);
  if b1~=b2
    G=zeros(size(I));
    D=find(L==b1);
    G(D)=1;
    tm=imresize(tm,size(G));
    GG=G.*tm;
    LS(:,:,1)=double(Q1(:,:,1)).*GG;
    LS(:,:,2)=double(Q1(:,:,2)).*GG;
    LS(:,:,3)=double(Q1(:,:,3)).*GG;
    F_LS=(LS(:,:,1)+LS(:,:,2)+LS(:,:,3))/3;    
    G=zeros(size(I));
    D=find(L==b2);
    G(D)=1;
    GG=G.*tm;
    LSB(:,:,1)=double(Q1(:,:,1)).*GG;
    LSB(:,:,2)=double(Q1(:,:,2)).*GG;
    LSB(:,:,3)=double(Q1(:,:,3)).*GG;
    F_LSB=(LSB(:,:,1)+LSB(:,:,2)+LSB(:,:,3))/3;
    fg=sum(sum(abs(F_LS-F_LSB)))/255;
    if fg<=30
        prf{p}=pr{dxc(ii)};
        p=p+1;
    end
    end
end
  tm2=zeros(size(I));
for ii=1:length(prf)
    [yy]=prf{ii};
     b1=yy(1);b2=yy(2);
     BB1=floor(C{b1});BB2=floor(C{b2});
     tm2(BB1(:,1),BB1(:,2))=1;
     tm2(BB2(:,1),BB2(:,2))=1;     
end
tm2=imresize(tm2,size(tm));
FF=tm1-tm-tm2;
FF=double(im2bw(FF));
figure,imshow(FF);
se=strel('octagon',12);
TT=imdilate(FF,se);
figure,imshow(TT);title('Detected forgery region')
z1(:,:,1)=TT.*double(Q1(:,:,1));
z1(:,:,2)=TT.*double(Q1(:,:,2));
z1(:,:,3)=TT.*double(Q1(:,:,3));
figure,imshow(uint8(z1));title('detected forged region');
% caluculation of precision and recall
cd manual
i=imread(nstr);
i=i(1:4:end,1:4:end,:);
cd ..
q=i(:,:,1);
msk=zeros(size(q));
for ii=1:size(q,1)
    for jj=1:size(q,2)
        if i(ii,jj,1)>=250 && i(ii,jj,2)<=2 && i(ii,jj,3)<=2
            msk(ii,jj)=1;
        end
    end
end

R=double(im2bw(TT));
Rg=double(im2bw(msk));
se=strel('octagon',6);
Rg=imdilate(Rg,se);
%figure,imshow(Rg);title('Ground truth region');
id1=numel(find(R==1));
id2=numel(find(Rg==1));
sp=intersect(find(R==1),find(Rg==1));
pre=numel(sp)/id1
rec=numel(sp)/id2



