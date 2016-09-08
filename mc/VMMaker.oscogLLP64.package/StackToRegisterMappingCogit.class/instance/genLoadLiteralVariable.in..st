bytecode generator support
genLoadLiteralVariable: litVarIndex in: destReg
	<inline: true>
	| association |
	association := self getLiteral: litVarIndex.
	destReg = ReceiverResultReg ifTrue: [ optStatus isReceiverResultRegLive: false ].
	self ssAllocateRequiredReg: destReg.
	self genMoveConstant: association R: destReg.
	objectRepresentation genEnsureObjInRegNotForwarded: destReg scratchReg: TempReg.