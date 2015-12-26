generate machine code - concretize
concretizeMoveCwR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	^machineCodeSize := self loadCwInto: (operands at: 1)