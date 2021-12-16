import pickle as pk
import struct
import os

# def binary(num):
#     return ''.join('{:0>8b}'.format(c) for c in struct.pack('!f', num))

# Binary read takes the original binary file, reads the byte stream up to 46 bytes, and then strips everything up to 46 bytes for header data.
# The function then augments the # of points data in the header binary, using the amount of elements in the truncated text file as a new # of points.
# The function then creates a new file and appends the augmented header into it.
def binary_read(bin_file_name, list_size):
    barray = bytearray(open(bin_file_name, "r+b").read())
    barray = barray[:46]

    barray[30:34] = (list_size).to_bytes(4, byteorder='big')
    barray[34:38] = (list_size).to_bytes(4, byteorder='big')

    new_bin_file = bin_file_name + "-new.txt"

    with open(new_bin_file, "wb") as binary_file:
        binary_file.write(barray)


# Split and combine will take the truncated text file and interpret every value as a double (float), the same data-type it is interpreted in the software.
# Split and combine will make a list of these floats and append it to the binary file created by the binar_read function.
def split_and_combine(trunc_file_name, bin_file_name):
    amp_list = []

    my_file = open(truc_file_name, 'r')
    reader = my_file.readlines()
    for row in reader:
        amp_list.append(float(row))

    binary_read(bin_file_name, len(amp_list))

    with open(bin_file_name, 'ab') as fbinary:
        pk.dump(amp_list, fbinary)

# trunc_file_name = Name and path of truncated file from igor, will be represented as a text file without headers.
# bin_file_name = Name and path of original binary file from labview, will be represented as binary file with headers.
split_and_combine(trunc_file_name, bin_file_name)
