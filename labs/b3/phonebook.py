#!/usr/bin/python3

import sys
import re

cmd = sys.argv[1]

db = "./phonebook.db"

def println(line):
	print(line, end='')

def writeln(f, line):
	f.write(line)
	f.write('\n')

def args():
	return " ".join(sys.argv[2:])

if cmd == "new":
	with open(db, "a+") as f:
		writeln(f, args())
elif cmd == "list":
	with open(db, "r+") as f:
		lines = f.readlines()
		if len(lines) == 0:
			print("Phonebook is empty")
		else:
			for line in lines:
				println(line)
elif cmd == "search":
	with open(db, "r+") as f:
		for line in f:
			if re.search(args(), line):
				println(line)
elif cmd == "clear":
	with open(db, "w+") as f:
		f.write("")
elif cmd == "remove":
	with open(db, "r+") as f:
		lines = f.readlines()
	with open(db, "w") as f:
		for line in lines:
			if not re.search(args(), line):
				f.write(line)
