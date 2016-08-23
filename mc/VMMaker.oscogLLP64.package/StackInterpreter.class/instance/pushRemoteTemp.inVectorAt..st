stack bytecodes
pushRemoteTemp: index inVectorAt: tempVectorIndex
	| tempVector |
	tempVector := self temporary: tempVectorIndex in: localFP.
	self internalPush: (objectMemory fetchPointer: index ofObject: tempVector)