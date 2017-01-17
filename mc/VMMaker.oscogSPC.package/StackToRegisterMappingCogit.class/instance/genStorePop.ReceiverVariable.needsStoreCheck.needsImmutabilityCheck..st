bytecode generator stores
genStorePop: popBoolean ReceiverVariable: slotIndex needsStoreCheck: needsStoreCheck needsImmutabilityCheck: needsImmCheck
	<inline: false>
	self ssFlushUpThroughReceiverVariable: slotIndex.
	self ensureReceiverResultRegContainsSelf.
	"In two path compilation the receiver is young AND mutable, hence no store check nor immutability check is needed"
	^self 
		genGenericStorePop: popBoolean 
		slotIndex: slotIndex 
		destReg: ReceiverResultReg 
		needsStoreCheck: (useTwoPaths not and: [needsStoreCheck])
		needsRestoreRcvr: true "ReceiverResultReg is kept live with the receiver across the operation"
		needsImmutabilityCheck: (needsImmCheck and: [useTwoPaths not])
		