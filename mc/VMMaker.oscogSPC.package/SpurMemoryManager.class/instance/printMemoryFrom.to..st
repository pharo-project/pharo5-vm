debug printing
printMemoryFrom: start to: end
	<doNotGenerate>
	| address |
	address := start bitAnd: (self wordSize - 1) bitInvert.
	[address < end] whileTrue:
		[coInterpreter printHex: address; printChar: $:; space; printHex: (self longAt: address); cr.
		 address := address + self wordSize]