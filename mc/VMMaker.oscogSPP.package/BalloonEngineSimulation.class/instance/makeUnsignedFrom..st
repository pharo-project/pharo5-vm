simulation
makeUnsignedFrom: integer
	integer < 0 
		ifTrue:[^(0 - integer - 1) bitInvert32]
		ifFalse:[^integer]