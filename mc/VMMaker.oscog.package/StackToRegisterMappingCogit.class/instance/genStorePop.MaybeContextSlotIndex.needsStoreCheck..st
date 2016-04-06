bytecode generator support
genStorePop: popBoolean MaybeContextSlotIndex: slotIndex needsStoreCheck: needsStoreCheck
	<inline: true>
	"This method expects ReceiverResultReg to hold the object to store into. It has to be ReceiverResultReg for the contextINstVarTrampoline"
	self 
		cppIf: IMMUTABILITY
		ifTrue: 
			[ self 
				genImmCheckStorePop: popBoolean 
				MaybeContextSlotIndex: slotIndex 
				needsStoreCheck: needsStoreCheck ]
		ifFalse: 
			[ self 
				genVanillaStorePop: popBoolean 
				MaybeContextSlotIndex: slotIndex 
				needsStoreCheck: needsStoreCheck ].