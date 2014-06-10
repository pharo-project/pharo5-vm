primitive generators
genInnerPrimitiveAsCharacter: retNOffset inReg: reg
	| jumpNotInt jumpOutOfRange |
	<var: 'jumpNotInt' type: #'AbstractInstruction *'>
	<var: 'jumpOutOfRange' type: #'AbstractInstruction *'>
	reg ~= ReceiverResultReg ifTrue:
		[cogit MoveR: reg R: TempReg.
		 jumpNotInt := self genJumpNotSmallIntegerInScratchReg: TempReg].
	cogit MoveR: reg R: TempReg.
	self genConvertSmallIntegerToIntegerInReg: TempReg.
	cogit CmpCq: (1 << 30) - 1 R: TempReg.
	jumpOutOfRange := cogit JumpAbove: 0.
	self genConvertSmallIntegerToCharacterInReg: reg.
	reg ~= ReceiverResultReg ifTrue:
		[cogit MoveR: reg R: ReceiverResultReg].
	cogit RetN: retNOffset.
	jumpOutOfRange jmpTarget: cogit Label.
	reg ~= ReceiverResultReg ifTrue:
		[jumpNotInt jmpTarget: jumpOutOfRange getJmpTarget].
	^0