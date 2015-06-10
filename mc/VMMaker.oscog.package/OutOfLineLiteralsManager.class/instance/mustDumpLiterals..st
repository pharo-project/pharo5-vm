testing
mustDumpLiterals: opcodeIndex
	<inline: true>
	^cogit getOpcodeIndex >= firstOpcodeIndex
	  and: [cogit getOpcodeIndex - firstOpcodeIndex >= cogit backEnd outOfLineLiteralOpcodeLimit]