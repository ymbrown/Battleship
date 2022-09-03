import numpy as np


def get_file_str(filename):
    total_file_str = []
    output0 = np.fromfile(open(filename), dtype=np.uint8)
    output_char = list(map(chr, output0[0:60]))
    for i in range(0, 6):
        section = output_char[i*10:i*10+10]
        new_str = ''
        count = 0
        for letter in section:
            if letter != '\x00':
                new_str += letter
            else:
                count += 1
        if count == 10:
            new_str = '0'
        total_file_str.append(new_str)
    return total_file_str


def make_msg(filelist):
    msg = []
    for i in range(0, 36):
        msg.append('0')

    for index, file in enumerate(filelist):
        column = get_file_str(file)
        for i in range(0, 6):
            msg[i * 6 + index] = column[i]

    return msg


output_files = ["output0.bin", "output1.bin", "output2.bin", "output3.bin", "output4.bin", "output5.bin"]
input_files = ["column0.bin", "column1.bin", "column2.bin", "column3.bin", "column4.bin", "column5.bin"]

input_msg = make_msg(input_files)
input_msg[21] = 'X'

output_msg = make_msg(output_files)

msg_length = len(input_msg)
final_msg = []

for k in range(0, msg_length):
    if input_msg[k] == 'X':
        final_msg.append(output_msg[k])
    else:
        final_msg.append(input_msg[k])


print(input_msg)
print(output_msg)
print(final_msg)
