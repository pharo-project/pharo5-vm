testing
mustDumpLiterals: opcodeIndex
	<inline: true>
	^cogit opcodeIndex >= firstOpcodeIndex
	  and: [cogit opcodeIndex - firstOpcodeIndex >= cogit backEnd outOfLineLiteralOpcodeLimit]