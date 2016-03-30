bytecode generator support
genStorePop: popBoolean ReceiverVariable: slotIndex
	<inline: false>
	self 
		cppIf: IMMUTABILITY
		ifTrue: [ ^ self genImmutabilityCheckStorePop: popBoolean ReceiverVariable: slotIndex ]
		ifFalse: [ ^ self genVanillaStorePop: popBoolean ReceiverVariable: slotIndex ]
		