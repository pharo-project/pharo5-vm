as yet unclassified
initialize
	super initialize.
	
	OneInstruction := 4.
	TwoInstructions := 8.
	
	HintLoad := 0.
	HintStore := 1.
		
	self initializeRegisters.
	self initializeOpcodes.
	self initializeSpecialFunctions.
	self initializeRegImmRts.