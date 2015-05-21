generate machine code - support
loadCwInto: destReg
	"Load the operand into the destination register, answering
	 the size of the instructions generated to do so."
	| operand distance |
	operand := operands at: 0.
	"First try and encode as a pc-relative reference..."
	(cogit addressIsInCurrentCompilation: operand) ifTrue:
		[distance := operand - (address + 8).
		 self rotateable8bitImmediate: distance
		 	ifTrue: [ :rot :immediate |
		 		self machineCodeAt: 0 put: (self add: destReg rn: PC imm: immediate ror: rot).
		 		^4]
		 	ifFalse:
		 		[self rotateable8bitImmediate: distance negated
		 			ifTrue: [ :rot :immediate |
		 				self machineCodeAt: 0 put: (self sub: destReg rn: PC imm: immediate ror: rot).
		 				^4]
					ifFalse: []]].
	"If this fails, use the conventional and painfully long 4 instruction sequence."
	^self at: 0 moveCw: operand intoR: destReg