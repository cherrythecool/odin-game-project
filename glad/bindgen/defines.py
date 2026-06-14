output = open("defines_output.txt", "w")

file = open("defines.txt")
lines = file.readlines()
file.close()
for line in lines:
    vals = line.replace("#define GL_", "").strip().split(" ")
    output.write(vals[0] + " :: " + vals[1] + "\n")

output.flush()
output.close()
