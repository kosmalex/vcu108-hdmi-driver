#%%
import numpy as np
import PIL.Image as Image
import matplotlib.pyplot as plt

file_name = "dummy"

# Read entire file into YUV
YUV   = np.fromfile(f'{file_name}.uyvy',dtype='uint8')
image = Image.open(f'{file_name}.jpeg')

# Guess a width and height and derive number of pixels in image
w,h = image.size
px = w*h

# print(YUV[:px*2].reshape((h, 971, 2)))
YUV = YUV.reshape((h, w, 2))

print(YUV.shape, YUV.size)
# Take first h x w samples and reshape as Y channel
# print(YUV[1:w*h+1:1].shape)
Y = YUV[:,   :, 1]
U = YUV[:, ::2, 0]
V = YUV[:,1::2, 0]

# print(Y)
# # Take next px/4 samples as U
# U = YUV[px:(px*5)//4].reshape(h//2,w//2)

# # Take next px/4 samples as V
# V = YUV[(px*5)//4:(px*6)//4].reshape(h//2,w//2)

# # Undo subsampling of U and V by doubling height and width
# Ufull = U.copy().resize((w,h))
# Vfull = V.copy().resize((w,h))

plt.imshow(Y)
plt.figure()
plt.imshow(U)
plt.figure()
plt.imshow(V)

V = V.reshape((V.size))

with open("./Y.mem", "w") as f:
  for y in Y.reshape((Y.size,)):
    f.write(f"{y:02x}\n")

with open("./UV.mem", "w") as f:
  for i, u in enumerate(U.reshape((U.size,))):
    v = V[i]
    f.write(f"{u:02x}{v:02x}\n")
#%%
import numpy as np

np.random.seed(32)

a = np.random.randint(0, 5, (2*5*2, ))

print(a)
a = a.reshape((2, 5, 2))
print(a)
print(a[:, :, 1])