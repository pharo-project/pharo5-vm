generate machine code - concretize
concretizeNegateR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| reg |
	reg := self concreteRegister: (operands at: 0).
	"rsb r?, r?, #0"
	self machineCodeAt: 0 put: (self type: 1 op: 3 set: 0 rn: reg rd: reg).
	^machineCodeSize := 4