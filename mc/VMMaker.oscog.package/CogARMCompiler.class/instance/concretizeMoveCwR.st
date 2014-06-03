generate machine code - concretize
concretizeMoveCwR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| constant destReg |
	constant := operands at: 0.
	destReg := self concreteRegister: (operands at: 1).
	^machineCodeSize :=self at: 0 moveCw: constant intoR: destReg