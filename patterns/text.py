




import os
work_dir = os.getcwd()
filepath = os.path.join(work_dir, "output.txt")
print(filepath)
with open(filepath, 'w') as fp:
    fp.write('blah blah this is the actual file we want to collect')

filepath = os.path.join(work_dir, f"out_out")
print(filepath)
with open(filepath, "w") as fp:
    fp.write('"output.txt"')