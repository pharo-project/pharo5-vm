stack bytecodes
pushTemporaryVariable: temporaryIndex

	self internalPush: (self temporary: temporaryIndex in: localFP).