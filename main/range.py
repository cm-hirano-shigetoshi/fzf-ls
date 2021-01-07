#!/usr/bin/env python
import re
import sys
import shlex

quotes = shlex.shlex().quotes
buf = sys.argv[1]
index = int(sys.argv[2])
m = re.match(r".*[\s{}](\S*)$".format(quotes), ' ' + buf[:index])
query = m.group(1)
print(buf[:(index - len(m.group(1)))])
print(m.group(1))
if index == len(buf) or buf[index] != ' ':
    print(' ', end='')
print(buf[index:])
