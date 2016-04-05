bytecode generator support
genStorePop: popBoolean RemoteInstVar: slotIndex At: objectIndex 
	<inline: false>
	self 
		cppIf: IMMUTABILITY
		ifTrue: [ ^ self genImmutabilityCheckStorePop: popBoolean RemoteInstVar: slotIndex At: objectIndex  ]
		ifFalse: [ ^ self genVanillaStorePop: popBoolean RemoteInstVar: slotIndex At: objectIndex  ]
		