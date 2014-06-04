generate machine code - concretize
concretizeMoveXbrRR
	"Will get inlined into concretizeAt: switch."
	
	<inline: true>
	| index base dest |
	index := self concreteRegister: (operands at: 0).
	base := self concreteRegister: (operands at: 1).
	dest := self concreteRegister: (operands at: 2).
	"LDR	dest, [base, +index, LSL #0]"
	"cond 011 1100 1 base dest 00000 00 0 inde"
	self machineCodeAt: 0 put: (self type: 3 op: 16rC set: 1 rn: base rd: dest shifterOperand: index).
	^machineCodeSize := 4