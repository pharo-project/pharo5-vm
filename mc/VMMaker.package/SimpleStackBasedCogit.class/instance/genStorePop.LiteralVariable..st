bytecode generators
genStorePop: popBoolean LiteralVariable: litVarIndex
	<inline: false>
	| association |
	self assert: needsFrame.
	association := self getLiteral: litVarIndex.
	self annotate: (self MoveCw: association R: ReceiverResultReg) objRef: association.
	objectRepresentation
		genEnsureObjInRegNotForwarded: ReceiverResultReg
		scratchReg: TempReg.
	popBoolean
		ifTrue: [self PopR: ClassReg]
		ifFalse: [self MoveMw: 0 r: SPReg R: ClassReg].
	traceStores > 0 ifTrue:
		[self CallRT: ceTraceStoreTrampoline].
	^objectRepresentation
		genStoreSourceReg: ClassReg
		slotIndex: ValueIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg