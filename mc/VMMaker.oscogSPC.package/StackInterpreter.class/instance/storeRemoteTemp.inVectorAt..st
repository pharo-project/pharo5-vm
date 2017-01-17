stack bytecodes
storeRemoteTemp: index inVectorAt: tempVectorIndex
	| tempVector |
	tempVector := self temporary: tempVectorIndex in: localFP.
	objectMemory storePointer: index ofObject: tempVector withValue: self internalStackTop.