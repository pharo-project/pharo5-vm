bytecode generator support
genVanillaStorePop: popBoolean ReceiverVariable: slotIndex 
	<inline: true>
	| topReg needStoreCheck |
	self ssFlushUpThroughReceiverVariable: slotIndex.
	needStoreCheck := self ssTopNeedsStoreCheck.
	"Note that ReceiverResultReg remains live after ceStoreCheckTrampoline."
	self ensureReceiverResultRegContainsSelf.
	topReg := self allocateRegForStackEntryAt: 0 notConflictingWith: (self registerMaskFor: ReceiverResultReg). 
	self ssStorePop: popBoolean toReg: topReg.
	objectRepresentation
		genStoreSourceReg: topReg
		slotIndex: slotIndex
		destReg: ReceiverResultReg
		scratchReg: TempReg
		inFrame: needsFrame
		needsStoreCheck: needStoreCheck.
	^ 0