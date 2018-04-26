from PIL import Image
from collections import Counter
from scipy.spatial import KDTree
import numpy as np
def hex_to_rgb(num):
    h = str(num)
    return int(h[0:4], 16), int(('0x' + h[4:6]), 16), int(('0x' + h[6:8]), 16)
def rgb_to_hex(num):
    h = str(num)
    return int(h[0:4], 16), int(('0x' + h[4:6]), 16), int(('0x' + h[6:8]), 16)
filename = raw_input("What's the image name? ")
new_w, new_h = map(int, raw_input("What's the new height x width? Like 28 28. ").split(' '))

im = Image.open("./sprite_originals/" + filename+ ".png") #Can be many different formats.
im = im.convert("RGBA")
layer = Image.new('RGBA',(new_w, new_h), (0,0,0,0))
layer.paste(im, (0, 0))
#im = layer
#im = im.resize((new_w, new_h),Image.ANTIALIAS) # regular resize

outImg = Image.new('RGB', layer.size, color='white')
outFile = open("./sprite_bytes/" + filename + '.txt', 'w')
for y in range(layer.size[1]):
    for x in range(layer.size[0]):
        pixel = layer.getpixel((x,y))
        print(pixel)
        outImg.putpixel((x,y), pixel)
        r, g, b, a = layer.getpixel((x,y))
        outFile.write("%.2x%.2x%.2x\n" %(r,g,b))
outFile.close()
outImg.save("./sprite_converted/" + filename+ ".png")
