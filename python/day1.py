import functools
import aoc

print([(lambda inp: (sum([(lambda elems: 10*int(elems[0]) + int(elems[-1]))([c for c in line if c.isdigit()]) for line in inp])))(start) for start in [aoc.read_input(1), [functools.reduce(lambda t, e: t.replace(e[0], e[1]), {"one": "o1e", "two":"t2o", "three":"t3e","four":"f4r","five":"f5e","six":"s6x","seven":"s7n","eight":"e8t","nine":"n9e"}.items(), x) for x in aoc.read_input(1)]]])