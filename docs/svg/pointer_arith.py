from dataclasses import dataclass

@dataclass
class Pointer:
    index: 0
    ptr: 0
    length: 0


def do_operation(a, b, op) -> [Pointer, Pointer]:
    a_addr = a.index + (a.ptr & ~0b1111)
    b_addr = b.index + (b.ptr & ~0b1111)

    c_addr = op(a_addr, b_addr)

    
    if a_addr <= c_addr < a_addr + a.length:
        res = Pointer(c_addr - a_addr, a.ptr, a.length)
        print("Doing {} on a {} and b {} results in address {} in a, pointer {}".format(op, a, b, c_addr, res))
    elif b_addr <= c_addr < b_addr + b.length:
        res = Pointer(c_addr - b_addr, b.ptr, b.length)
        print("Doing {} on a {} and b {} results in address {} in b, pointer {}".format(op, a, b, c_addr, res))
    else:
        res = Pointer(c_addr - a_addr, a.ptr, a.length)
        print("Doing {} on a {} and b {} results in address {} in none, pointer {}".format(op, a, b, c_addr, res))

    return res

def add(a, b):
    return a + b

def xor(a, b):
    return a ^ b


a = Pointer(0, 0x17, 4)
b = Pointer(8, 0x47, 10)

mix = do_operation(a, b, xor)

a_rest = do_operation(b, mix, xor)
b_rest = do_operation(a, mix, xor)