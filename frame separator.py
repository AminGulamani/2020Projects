import cv2
import os

color = "Org"
trial = "Trial3"

filepath = "C:/Users/Amin Gulamani/Desktop/Chem IA files/"+color+"/"
savepath = filepath+trial+color+"Frames"
imgsavepath = filepath+trial+color+"Frames/frame%d.jpg"

os.mkdir(savepath)

vidcap = cv2.VideoCapture(filepath + trial+color+'.MOV')

success,image = vidcap.read()
count = 0
while success:
  cv2.imwrite( imgsavepath % count, image)     # save frame as JPEG file
  success,image = vidcap.read()
  count += 1
  print(count)