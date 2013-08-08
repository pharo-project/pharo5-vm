generate machine code - concretize
concretizeMoveCwR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| constant destReg |
	constant := operands at: 0.
	destReg := self concreteRegister: (operands at: 1).
	self at: 0 moveCw: constant intoR: destReg.
	^machineCodeSize := 16.