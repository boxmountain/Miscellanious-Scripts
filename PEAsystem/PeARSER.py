import pandas as pd
import struct
import os

# print(struct.unpack('>d', barray[2:10])[0])               <--- Prints "Material Name" as I16
# print(struct.unpack('>d', barray[10:18])[0])              <--- Prints "Delay_Time" as Double
# print(struct.unpack('>d', barray[18:26])[0])              <--- Prints "dt" as Double
# print(struct.unpack('>i', barray[26:30])[0])              <--- Prints "TBM" as I32
# print(struct.unpack('>i', barray[30:34])[0])              <--- Prints "Nwaves" as I32
# print(struct.unpack('>i', barray[34:38])[0])              <--- Prints "Wpoints" as I32
# print(struct.unpack('>d', barray[38:46])[0])              <--- Prints "HVDC" as Double ??
# print(struct.unpack('>d', barray[46:54])[0])              <--- Prints the first amplitude value as Double



def binary_read(file_name):                                                         #Function accepts file name as input.
    barray = open(file_name, "rb").read()                                           #Opens the binary file and saves byte stream to array called "barray".

    time_list = [struct.unpack('>d', barray[2:10])[0]]                              #Calls unpack to interpet the bytes at location 2 through 10 in barray, as double. This value defines delay_time, which is the first time value in the time array. Appends this value to the time_list array. The bytes must be interpreted in big-endian, hence '>d'.
    amp_list = []                                                                   #Creates a list called amp_list which will hold the amplitude data.

    for num in range(struct.unpack('>i', barray[30:34])[0] - 1):                    #This for loop uses the Wpoints value in the header. This ensures that the time_list array will have as many points as the amplitude array.
        time_list.append(time_list[num] + struct.unpack('>d', barray[10:18])[0])    #This portion calls the dt value in the headers and adds that value over and over again in the time_list array. dt defines the time step between data points.

    main_count = 46                                                                 #All the headers are contained in the first 46 bytes, setting main_count to 46 ensures the script won't include any headers into the amplitude data.

    while main_count < len(barray):                                                 #This loop interprets all the amplitude data as Double and appends it to amp_list array. It starts at byte 46, increments by +8, and ends when main_count > len(barray).
        try:
            amp_list.append(struct.unpack('>d', barray[main_count:main_count+8])[0])
        except struct.error:
            pass
        main_count += 8

    header = file_name.replace('.txt', '')                                          #Calls the file_name value, deletes .txt in the name, and saves as header value (for the top of output columns). This is something you'll need to tweak to work for you, because there are too many characters to correctly import as headers in IGOR.

    time_list = pd.DataFrame({header + '_time':time_list})                          #Creates dataframe from time_list data and appends header + '_time' string to header of column.
    amp_list = pd.DataFrame({header:amp_list})                                      #Creates dataframe from amp_list data and appends header string to header of column.
    sectional = pd.concat([time_list, amp_list], axis=1)                            #Concatenates the time_list and amp_list dataframes into one dataframe with two columns.

    return sectional                                                                #Returns concatenated dataframe when this funciton is called.

file_list = os.listdir()                                                            #Calls listdir() to list names of all files in the current directory and save list as the file_list array.
main_list = []                                                                      #Creates an empty array, known as main_list, which will hold all the dataframes the function spits out.

for names in file_list:                                                             #For loop iterates through all the names in the file_list array, if there are any files with '.py' at the end, it ignores that file.
    if '.py' in names:
        pass
    else:
        main_list.append(binary_read(names))                                        #If the file does not have '.py' in its name, then call the binary_read() function with the file_name, append returned dataframe to array called main_list.

final = pd.concat(main_list, axis=1)                                                #Concatenates all the dataframes in main_list, to a dataframe called final.

final.to_csv('FULL_DATA_SET.txt', sep='\t', index=False)                            #Creates a tab delimited file which contains all the extracted data and saves it as 'FULL_DATA_SET.txt'
