generate machine code
concretizeAlignmentNops
	<inline: true>
	self flag: 'if performance is an issue generate longer nops'.
	0 to: machineCodeSize - 1 do:
		[:i|
		machineCode at: i put: 16r90]