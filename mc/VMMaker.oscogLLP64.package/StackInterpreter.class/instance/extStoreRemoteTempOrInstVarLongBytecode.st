stack bytecodes
extStoreRemoteTempOrInstVarLongBytecode
	<inline: true>
	| slotIndex tempIndex object |
	slotIndex := self fetchByte.
	tempIndex := self fetchByte.
	self fetchNextBytecode.
	(tempIndex noMask: self remoteIsInstVarAccess)
		ifTrue: [self storeRemoteTemp: slotIndex inVectorAt: tempIndex]
		ifFalse: 
			[ slotIndex := slotIndex + (extA << 8).
			tempIndex := tempIndex - self remoteIsInstVarAccess.
			extA := extB := 0.
			object := self temporary: tempIndex in: localFP.
			self storeMaybeContext: object receiverVariable: slotIndex withValue: self internalStackTop ]