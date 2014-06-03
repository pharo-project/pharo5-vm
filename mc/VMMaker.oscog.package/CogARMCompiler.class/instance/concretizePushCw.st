generate machine code - concretize
concretizePushCw
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| word instrOffset|
	word := operands at: 0.
	instrOffset := self at: 0 moveCw: word intoR: RISCTempReg.
	self machineCodeAt: instrOffset put: (self pushR: RISCTempReg).
	^machineCodeSize := instrOffset + 4