generate machine code
concretizeNop
	<inline: true>
	machineCode at: 0 put: 16r90.
	^machineCodeSize := 1