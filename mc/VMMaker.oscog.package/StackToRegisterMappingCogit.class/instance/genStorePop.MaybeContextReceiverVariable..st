bytecode generator support
genStorePop: popBoolean MaybeContextReceiverVariable: slotIndex
	<inline: false>
	self 
		cppIf: IMMUTABILITY
		ifTrue: [ ^ self genImmutabilityCheckStorePop: popBoolean MaybeContextReceiverVariable: slotIndex ]
		ifFalse: [ ^ self genVanillaStorePop: popBoolean MaybeContextReceiverVariable: slotIndex ]