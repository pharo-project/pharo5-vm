stack bytecodes
extPushRemoteTempOrInstVarLongBytecode
	| slotIndex tempIndex object |
	slotIndex := self fetchByte.
	tempIndex := self fetchByte.
	self fetchNextBytecode.
	(tempIndex noMask: self remoteIsInstVarAccess)
		ifTrue: [self pushRemoteTemp: slotIndex inVectorAt: tempIndex]
		ifFalse: 
			[ slotIndex := slotIndex + (extA << 8).
			tempIndex := tempIndex - self remoteIsInstVarAccess.
			extA := extB := 0.
			object := self temporary: tempIndex in: localFP.
			self pushMaybeContext: object receiverVariable: slotIndex ]