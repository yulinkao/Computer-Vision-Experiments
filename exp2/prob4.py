# -*- coding: utf-8 -*-
from PIL import Image  
from pylab import * 
import numpy as np 
import cv2

if __name__ == '__main__':
    im = array(Image.open('try.jpg'))  
    imshow(im) 
    # 原图中的4个点
    src_point = ginput(4)  
    src_point = np.float32(src_point)

    # 想要图像的大小，（列数，行数）
    dsize=(750,900)

    dst_point = np.float32([[0,0],[0,dsize[1]-1],[dsize[0]-1,dsize[1]-1],[dsize[0]-1,0]])
    # 逆时针4个点，一一对应，找到映射矩阵h
    h, s = cv2.findHomography(src_point, dst_point, cv2.RANSAC, 10)   
    book = cv2.warpPerspective(im, h, dsize)
    # Image.open读入的图像是RGB，cv2.imwrite保存的是BGR
    book = cv2.cvtColor(book, cv2.COLOR_RGB2BGR)
    cv2.imwrite('picget.jpg',book)
