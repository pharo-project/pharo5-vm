bytecode generator support
genStorePop: popBoolean slotIndex: slotIndex destReg: destReg needsStoreCheck: needsStoreCheck needsRestoreRcvr: needsRestoreReceiver
	<inline: true>
	"This method expects destReg to hold the object to store into. In practice, it is almost always RcvrResultReg because it is mandatory for the various store checks. We could put any register there if no store check is needed"
	self 
		cppIf: IMMUTABILITY
		ifTrue: 
			[needsTwoPath
				ifTrue: 
					[self  "first path, receiver is mutable"
						genVanillaStorePop: popBoolean 
						slotIndex: slotIndex 
						destReg: destReg 
						needsStoreCheck: needsStoreCheck]
				ifFalse: 
					[self 
						genImmCheckStorePop: popBoolean 
						slotIndex: slotIndex 
						destReg: destReg 
						needsStoreCheck: needsStoreCheck
						needsRestoreRcvr: needsRestoreReceiver]]
		ifFalse: 
			[self 
				genVanillaStorePop: popBoolean 
				slotIndex: slotIndex 
				destReg: destReg 
				needsStoreCheck: needsStoreCheck].
		