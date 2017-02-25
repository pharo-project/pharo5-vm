testing
mustDumpLiterals: currentOpcodeIndex
	<inline: true>
	^currentOpcodeIndex >= firstOpcodeIndex
	  and: [currentOpcodeIndex - firstOpcodeIndex >= cogit backEnd outOfLineLiteralOpcodeLimit]