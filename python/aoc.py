import itertools

def read_input(nr):
    lines = []
    with open(f"../inputs/{nr}.inp") as fp:
        lines = fp.readlines()
    return lines

def read_input_int(nr):
    return [int(x) for x in read_input(nr)]

def cartesian_set_reflective2(set):
    return list(itertools.product(set, set))

def cartesian_set_reflective3(set):
    return list(itertools.product(set, set, set))