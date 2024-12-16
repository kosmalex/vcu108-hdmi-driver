#%%
import numpy as np
import PIL.Image as Image
import matplotlib.pyplot as plt

file_name = "me"

# Read entire file into YUV
YUV = np.fromfile(f'{file_name}.uyvy',dtype='uint32')
# print(f"{YUV[0]:06x}")
# print(f"{(len(YUV) * 2):06x}")
# for y in YUV[1::2]:
#   print(f"{y:04x}")

# print(len(YUV[::2]))
# print(len(YUV[1::2]))

with open("../mem/UY.mem", "w") as f:
  for i in YUV:
    f.write(f"{i:08x}\n")

# with open("../mem/VY.mem", "w") as f:
#   for i in YUV[1::2]:
#     f.write(f"{i:04x}\n")


# with open("../mem/UY.mem", "w") as f:
#   zeros = np.zeros((len(YUV),)).astype('uint32')
#   for zero in zeros:
#     f.write(f"{zero:004x}\n")
#   # f.write(f";")

# YUV = np.fromfile(f'{file_name}.uyvy',dtype='uint8')
# for i in YUV[:4]:
#   print(f"{i:02x}")
# print(f"{(len(YUV)):06x}")

# yuyv = YUV[:4]
# vyuy = yuyv[::-1]

# for i in vyuy:
#   print(f"{i:x}")

# print(f"{(vyuy[0] * 2**8 + vyuy[1]):0x}",f"{(vyuy[2] * 2**8 + vyuy[3]):0x}")

# print(f"{YUV[0]:x}")

# with open("me_64.coe", "w") as f:
#   f.write("memory_initialization_radix=16;\nmemory_initialization_vector=")

#   for yuv in YUV:
#     f.write(f"\n{yuv:016x}")
#   f.write(f";")