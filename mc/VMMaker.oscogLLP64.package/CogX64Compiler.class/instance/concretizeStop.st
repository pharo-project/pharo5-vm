generate machine code
concretizeStop
	<inline: true>
	machineCode at: 0 put: 16rCC.
	^machineCodeSize := 1