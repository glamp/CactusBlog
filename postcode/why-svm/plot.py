import numpy as np
import matplotlib.pyplot as plt
import pylab as pl

from matplotlib._png import read_png

f = '/Users/glamp/Dropbox/blog/logo/mryak.png'

arr_yak = read_png(f)

for (x, y) in [(1, 1), (2, 2), (3, 3)]:
    print x, y
fig = plt.figure(fig=(10, 10))
ax = fig.add_axes([0.1,0.1,0.8,0.8])
axicon = fig.add_axes([0.2,0.4,0.1,0.1])
ax.plot()
axicon.imshow(arr_yak)
axicon.set_xticks([])
axicon.set_yticks([])
fig.show()

plt.show()