debug printing
printStackPages
	0 to: numStackPages - 1 do:
		[:i|
		self printStackPage: (stackPages stackPageAt: i).
		self cr]