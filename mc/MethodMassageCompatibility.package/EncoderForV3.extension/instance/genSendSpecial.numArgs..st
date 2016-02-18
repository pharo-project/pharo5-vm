*MethodMassageCompatibility-bytecode generation
genSendSpecial: specialSelectorIndex numArgs: nArgs
	"See BlueBook page 596"
	self assert: (specialSelectorIndex between: 1 and: Smalltalk specialSelectorSize).
	self assert: nArgs = (Smalltalk specialNargsAt: specialSelectorIndex).
	"Special selector sends.
		176-191 	1011iiii 	Send Arithmetic Message #iiii
		192-207 	1100iiii 	Send Special Message #iiii"
	stream nextPut: specialSelectorIndex + 175