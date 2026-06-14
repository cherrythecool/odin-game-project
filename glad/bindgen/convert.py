def ctype_to_odin(type):
    zig_return = type

    if type.startswith("const"):
        zig_return = "#by_ptr " + zig_return.split("const ")[1]

        if zig_return.endswith("*"):
            zig_return = zig_return.split("*")[0].strip()
    elif zig_return.endswith("*"):
        zig_return = "^" + zig_return.split("*")[0]
    # if not zig_return.endswith("void"):
    #     split_return = zig_return.split(" ")
    #     if len(split_return) == 2:
    #         split_return = zig_return.split("]")
    #         split_return[0] += "]"

    #     if len(split_return) > 1:
    #         return split_return[0] + " c." + split_return[1]
    #     else:
    #         return "c." + zig_return

    return zig_return

output = open("output.txt", "w")

file = open("input_c.txt")
split_lines = file.readlines()
file.close()

i = 0

for line in split_lines:
    if not line.startswith("typedef"):
        break

    line = line.strip()
    return_value = line.replace("typedef ", "").split(" (GLAD_API")[0]
    zig_return = ctype_to_odin(return_value)

    if zig_return == "void":
        zig_return = ""
    else:
        zig_return = f" -> {zig_return}"

    data = line.replace("typedef " + return_value + " (GLAD_API_PTR *PFN", "").replace("PROC)(", " ").replace(");", "").split(" ", 1)
    func_name = split_lines[i + int(len(split_lines) / 2)].split(" ")[1].replace(";", "").strip()
    name = func_name
    name = name.replace(name[0], name[0].lower(), 1)

    args = data[1]
    args_split = args.split(", ")
    zig_args = ""
    func_args = ""
    if args_split[0] == "void":
        args_split = []
    for arg in args_split:
        split_arg = arg.rsplit(" ", 1)
        if split_arg[1] == "type":
            split_arg[1] = "gl_type"

        fuck_type = ctype_to_odin(split_arg[0]).strip()
        starting_shit = ""
        if fuck_type.startswith("#by_ptr"):
            starting_shit = "#by_ptr "
            fuck_type = fuck_type.split("#by_ptr ")[1]

        zig_args += ", " + starting_shit + split_arg[1] + ": " + fuck_type
        func_args += ", " + split_arg[1]
    if zig_args.startswith(", "):
        zig_args = zig_args.replace(", ", "", 1)

    output.write(f'{func_name}: proc "c" ({zig_args}){zig_return},\n')
    #output.write(f"{{ name: '{name}', zig_args: '{zig_args}', zig_return: '{zig_return}', func_name: '{func_name}', func_args: '{func_args}' }}\n")
    # output.write("pub fn " + name + "(self: *const Self" + zig_args + ") " + zig_return + " {\n\t" + ("return " if zig_return != "void" else "") + "self.context." + func_name + ".?(" + func_args + ");\n}\n\n")
    i += 1

output.flush()
output.close()
