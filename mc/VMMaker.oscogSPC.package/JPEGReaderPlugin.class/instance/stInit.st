initialize
stInit
	self cCode:'' inSmalltalk:[
		yComponent := CArrayAccessor on: (IntegerArray new: MinComponentSize).
		cbComponent := CArrayAccessor on: (IntegerArray new: MinComponentSize).
		crComponent := CArrayAccessor on: (IntegerArray new: MinComponentSize).
		yBlocks := CArrayAccessor on: (Array new: MaxMCUBlocks).
		crBlocks := CArrayAccessor on: (Array new: MaxMCUBlocks).
		cbBlocks := CArrayAccessor on: (Array new: MaxMCUBlocks).
		jpegNaturalOrder := CArrayAccessor on: #(
			0 1 8 16 9 2 3 10 
			17 24 32 25 18 11 4 5 
			12 19 26 33 40 48 41 34 
			27 20 13 6 7 14 21 28 
			35 42 49 56 57 50 43 36 
			29 22 15 23 30 37 44 51 
			58 59 52 45 38 31 39 46 
			53 60 61 54 47 55 62 63).
	].