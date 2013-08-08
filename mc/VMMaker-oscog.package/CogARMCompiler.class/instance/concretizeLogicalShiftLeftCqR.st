generate machine code - concretize
concretizeLogicalShiftLeftCqR
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| distance reg |
	distance := (operands at: 0) min: 31.
	reg := self concreteRegister: (operands at: 1).
	"cond 000 1101 0 0000 dest dista 000 srcR"
	self machineCodeAt: 0 put: (self t: 0 o: 16rD s: 0 rn: 0 rd: reg shifterOperand: (distance << 7 bitOr: reg)).
	^machineCodeSize := 4