#opencv模板匹配----单目标匹配
import cv2
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.cm as cm

#读取目标图片
target2 = cv2.imread("/Users/mable/Desktop/Figure_1.png")
target = cv2.imread("/Users/mable/Desktop/pic.jpg")
target4 = cv2.imread("/Users/mable/Desktop/Figure_1.png")
target3 = cv2.imread("/Users/mable/Desktop/pic.jpg")

#读取模板图片
template = cv2.imread("/Users/mable/Desktop/template.png")

#获得模板图片的高宽尺寸
sp = template.shape
theight = sp[0]
twidth = sp[1]

#执行模板匹配，采用的匹配方式cv2.TM_SQDIFF
result = cv2.matchTemplate(target,template,cv2.TM_SQDIFF)

#归一化处理
cv2.normalize( result, result, 0, 1, cv2.NORM_MINMAX, -1 )

#寻找矩阵（一维数组当做向量，用Mat定义）中的最大值和最小值的匹配结果及其位置
min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(result)

#匹配值转换为字符串
#对于cv2.TM_SQDIFF及cv2.TM_SQDIFF_NORMED方法min_val越趋近与0匹配度越好，匹配位置取min_loc
#对于其他方法max_val越趋近于1匹配度越好，匹配位置取max_loc
strmin_val = str(min_val)

#绘制矩形边框，将匹配区域标注出来
#min_loc：矩形定点
#(min_loc[0]+twidth,min_loc[1]+theight)：矩形的宽高
#(0,0,225)：矩形的边框颜色；2：矩形边框宽度
cv2.rectangle(target,min_loc,(min_loc[0]+twidth,min_loc[1]+theight),(0,0,225),10)

#执行模板匹配，采用的匹配方式cv2.TM_CCORR_NORMED
result = cv2.matchTemplate(target3,template,cv2.TM_CCORR_NORMED)
cv2.normalize( result, result, 0, 1, cv2.NORM_MINMAX, -1 )
min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(result)
strmin_val = str(max_val)
cv2.rectangle(target3,min_loc,(min_loc[0]+twidth,min_loc[1]+theight),(0,0,225),10)

#执行模板匹配，采用的匹配方式cv2.TM_SQDIFF
result = cv2.matchTemplate(target2,template,cv2.TM_SQDIFF)
cv2.normalize( result, result, 0, 1, cv2.NORM_MINMAX, -1 )
min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(result)
strmin_val = str(min_val)
cv2.rectangle(target2,min_loc,(min_loc[0]+twidth,min_loc[1]+theight),(0,0,225),10)

#执行模板匹配，采用的匹配方式cv2.TM_CCORR_NORMED
result = cv2.matchTemplate(target4,template,cv2.TM_CCORR_NORMED)
cv2.normalize( result, result, 0, 1, cv2.NORM_MINMAX, -1 )
min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(result)
strmin_val = str(max_val)
cv2.rectangle(target4,min_loc,(min_loc[0]+twidth,min_loc[1]+theight),(0,0,225),10)

#cv2 to plt
target_2 = target[:,:,[2,1,0]]
target2_2 = target2[:,:,[2,1,0]]
target3_2 = target3[:,:,[2,1,0]]
target4_2 = target4[:,:,[2,1,0]]

#显示结果
plt.subplot(2,2,1)
plt.imshow(target_2)
plt.axis("off")

plt.subplot(2,2,2)
plt.imshow(target2_2)
plt.axis("off")

plt.subplot(2,2,3)
plt.imshow(target3_2)
plt.axis("off")

plt.subplot(2,2,4)
plt.imshow(target4_2)
plt.axis("off")

plt.show()

