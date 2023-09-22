import cv2
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.cm as cm

#read image1
img0=cv2.imread(r'/Users/mable/Desktop/img/jpg-compress/008.jpg')
#read image2
img2=cv2.imread(r'/Users/mable/Desktop/img/jpg-compress/010.jpg')

#000 is original picture
#060 => 0.60 exposure...etc

img0=cv2.cvtColor(img0,cv2.COLOR_BGR2GRAY)
img2=cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
img=img0.copy()

mHist1=[]
mNum1=[]
inhist1=[]
mHist2=[]
mNum2=[]
inhist2=[]

#step1. Calculate the cumulative histogram of the first image
for i in range(256):
    mHist1.append(0)
row,col=img.shape

for i in range(row):
    for j in range(col):
        mHist1[img[i,j]]= mHist1[img[i,j]]+1
mNum1.append(mHist1[0]/img.size)

for i in range(0,255):
    mNum1.append(mNum1[i]+mHist1[i+1]/img.size)
    
for i in range(256):
    inhist1.append(round(255*mNum1[i]))
    

#step2. Calculate the cumulative histogram of the second image
for i in range(256):
    mHist2.append(0)
rows,cols=img2.shape

for i in range(rows):
    for j in range(cols):
        mHist2[img2[i,j]]= mHist2[img2[i,j]]+1
mNum2.append(mHist2[0]/img2.size)

for i in range(0,255):
    mNum2.append(mNum2[i]+mHist2[i+1]/img2.size)

for i in range(256):
    inhist2.append(round(255*mNum2[i]))

#step3. build
g=[]

for i in range(256):
    a=inhist1[i]
    flag=True
    for j in range(256):
        if inhist2[j]==a:
            g.append(j)
            flag=False
            break
    if flag==True:
        minp=255
        for j in range(256):
            b=abs(inhist2[j]-a)
            if b<minp:                        
                minp=b
                jmin=j
        g.append(jmin)

for i in range(row):
    for j in range(col):
        img[i,j]=g[img[i,j]]

#step4. 
plt.subplot(3,2,1)
plt.hist(img0.ravel(),256)
plt.subplot(3,2,2)
plt.imshow(img0,cmap=cm.gray)
plt.axis("off")

plt.subplot(3,2,3)
plt.hist(img2.ravel(),256)
plt.subplot(3,2,4)
plt.imshow(img2,cmap=cm.gray)
plt.axis("off")

plt.subplot(3,2,5)
plt.hist(img.ravel(),256)
plt.subplot(3,2,6)
plt.imshow(img,cmap=cm.gray)
plt.axis("off")

plt.show()
