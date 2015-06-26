generate machine code - concretize
concretizeConvertRRd
	"Will get inlined into concretizeAt: switch."
	<inline: true>
	| srcReg destReg |
	srcReg := self concreteRegister: (operands at:0).
	destReg := self concreteDPFPRegister: (operands at: 1).
	machineCode at: 0 put:(self fmsrFrom: srcReg to: 9).
	machineCode at: 1 put: (self fsitodFrom: 9 to: destReg). "probably not quite right"
	^machineCodeSize := 8
		
