generate machine code - concretize
concretizeNegateR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| reg |
	reg := self concreteRegister: (operands at: 0).
	"rsb r?, r?, #0"
	self machineCodeAt: 0 put: (self t: 1 o: 3 s: 0 rn: reg rd: reg).
	^machineCodeSize := 4