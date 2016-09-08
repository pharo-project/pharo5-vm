tests
testGenerateMul
	"self new testGenerateMul"
	"Currently demonstrates that the CogARMCompiler>genMulR:R: algorithm ain't gonna work too well"
	
	|memory compiler |
	compiler := self gen: nil. "grab something usefully like a compiler for later abuse"
	self resetGen. "initialise important stuff"

	"test MulRR"
	self gen: LogicalShiftLeftCqR operand: 1 operand:1. "LSL r1 - to make the right bit pattern for a SmallInt that has had the flag masked out"
	self gen: LogicalShiftLeftCqR operand: 1 operand:0. "LSL r1 - to make the right bit pattern for a SmallInt that has had the flag masked out"
	self gen: MoveRR operand: 0 operand: 2.
	compiler genMulR: 1 R: 0.
	memory := self generateInstructions.
	self disassembleOpcodesIn: memory to: Transcript	.
	{SmallInteger maxVal@2. SmallInteger minVal@2. 0@0. 1@1. -1@0. -1@1. -1@ -1} do:[:val | | x y |
			x := val x.
			y := val y.
			self processor reset.
			processor signedLongAt: 13 put: x;
				signedLongAt: 17 put: y.
			[[processor pc < memory size] whileTrue:
						[self processor singleStepIn: memory]]
						on: Error
						do: [:ex| ].
			Transcript show: x asString, ' * ', y asString; cr.
			processor printRegisterState: processor registerState on: Transcript.
			Transcript flush]
	
