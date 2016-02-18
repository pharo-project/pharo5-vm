bytecode generator support
genPushLiteralVariable: literalIndex
	<inline: false>
	| association freeReg |
	freeReg := self allocateRegNotConflictingWith: 0.
	association := self getLiteral: literalIndex.
	"N.B. Do _not_ use ReceiverResultReg to avoid overwriting receiver in assignment in frameless methods."
	"So far descriptors are not rich enough to describe the entire dereference so generate the register
	 load but don't push the result.  There is an order-of-evaluation issue if we defer the dereference."
	self genMoveConstant: association R: TempReg.
	objectRepresentation
		genEnsureObjInRegNotForwarded: TempReg
		scratchReg: freeReg.
	objectRepresentation
		genLoadSlot: ValueIndex
		sourceReg: TempReg
		destReg: freeReg.
	self ssPushRegister: freeReg.
	^0