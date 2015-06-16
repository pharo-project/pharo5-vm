generate machine code - support
loadCwInto: destReg
	"Load the operand into the destination register, answering
	 the size of the instructions generated to do so."
	| operand distance |
	operand := operands at: 0.
	(self isAnInstruction: (cogit cCoerceSimple: operand to: #'AbstractInstruction *')) ifTrue:
		[operand := (cogit cCoerceSimple: operand to: #'AbstractInstruction *') address].
	"First try and encode as a pc-relative reference..."
	(cogit addressIsInCurrentCompilation: operand) ifTrue:
		[distance := operand - (address + 8).
		 self rotateable8bitSignedImmediate: distance
		 	ifTrue:
				[:rot :immediate :negate|
		 		 self machineCodeAt: 0 put: (negate
												ifTrue: [self sub: destReg rn: PC imm: immediate ror: rot]
												ifFalse: [self add: destReg rn: PC imm: immediate ror: rot]).
		 		^4]
		 	ifFalse:
		 		[self deny: (self isAnInstruction: (cogit cCoerceSimple: (operands at: 0) to: #'AbstractInstruction *'))]].
	"If this fails, use the conventional literal load sequence."
	^self moveCw: operand intoR: destReg