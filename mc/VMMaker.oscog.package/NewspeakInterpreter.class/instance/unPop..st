internal interpreter access
unPop: nItems
	stackPointer := stackPointer + (nItems*self wordSize)