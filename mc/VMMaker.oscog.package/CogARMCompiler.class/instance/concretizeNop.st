generate machine code - concretize
concretizeNop
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	"MOV r0, r0"
	self machineCodeAt: 0 put: 16rE1A00000.
	^machineCodeSize := 4
			