generate machine code - concretize
concretizeNop
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	self machineCodeAt: 0 put: 16rE1A01001.
	^machineCodeSize := 4
			