*MethodMassageCompatibility-opcode sizing
sizeSpecialSend: specialSelectorIndex numArgs: nArgs
	^self sizeOpcodeSelector: #genSendSpecial:numArgs: withArguments: {specialSelectorIndex. nArgs}