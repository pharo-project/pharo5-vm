generate machine code - concretize
concretizePushCw
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| instrOffset |
	instrOffset := self loadCwInto: ConcreteIPReg.
	self machineCodeAt: instrOffset put: (self pushR: ConcreteIPReg).
	^machineCodeSize := instrOffset + 4