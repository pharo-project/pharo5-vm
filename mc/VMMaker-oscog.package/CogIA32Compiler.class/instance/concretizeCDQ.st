generate machine code
concretizeCDQ
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	machineCode at: 0 put: 16r99.
	^machineCodeSize := 1