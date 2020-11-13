from PIL import Image
import numpy as np
import os

darkbois = []
lightbois = []
framesComplete = 0

color = "Org"
trial = "Trial3"

filepath = "C:/Users/Amin Gulamani/Desktop/Chem IA files/"+color+"/"+trial+color+"Frames/"
filepathsave = "C:/Users/Amin Gulamani/Desktop/Chem IA files/"+color+"/"+trial+color+"/"
filepathsavetxt = "C:/Users/Amin Gulamani/Desktop/Chem IA files/"+color+"/"+trial+color+".txt"
ist = os.listdir(filepath)
ist = list(ist)

ist.sort(key=len)
print(ist)
ist = ist[:24000]

for x in ist:
    # Open image and make RGB and HSV versions
    RGBim = Image.open(filepath+x).convert('RGB')
    # Make numpy versions
    RGBna = np.array(RGBim)
    # Extract brightness
    B=RGBna.mean(axis=2)
    # Set sensitivity
    hi = 7
    # set our dark filter
    dark = np.where(B<hi)
    # Make all pixels in dark bright fucking red
    RGBna[dark] = [255,0,0]
    #count n spit
    count = dark[0].size
    framesComplete = framesComplete +1
    percentCount = count/20736
    percentComplete = 100*framesComplete/len(ist)

    if percentCount <=15:
        lightbois.append(x)

    if percentCount >= 95:
        darkbois.append(x)

    print("Pixels matched: {0} of 2073600 in {1} that's a solid {2} dark. As well we are {3} frames in, or {4} percent through!! ".format(count,x,percentCount,framesComplete,percentComplete))
    Image.fromarray(RGBna).save(filepathsave+'{}'.format(x))
yabois = []
for x in ist:
    if x not in lightbois:
        if x not in darkbois:
            yabois.append(x)
print(yabois)
f= open(filepathsavetxt,"w+")
f.write("darkframes are"+str(darkbois)+"\n\nlightframes are"+str(lightbois)+"\n\nvalid frames are" + str(yabois) + "\n\n range is:"+yabois[0]+"to"+yabois[-1])
