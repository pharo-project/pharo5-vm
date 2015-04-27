bytecode generator support
genPushLiteralVariable: literalIndex
	<inline: false>
	| association |
	association := self getLiteral: literalIndex.
	"N.B. Do _not_ use ReceiverResultReg to avoid overwriting receiver in assignment in frameless methods."
	self genMoveConstant: association R: ClassReg.
	objectRepresentation
		genEnsureObjInRegNotForwarded: ClassReg
		scratchReg: TempReg.
	objectRepresentation
		genLoadSlot: ValueIndex
		sourceReg: ClassReg
		destReg: TempReg.
	self PushR: TempReg.
	^0