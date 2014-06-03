stack bytecodes
pushRemoteTemp: index inVectorAt: tempVectorIndex
	| tempVector |
	tempVector := self temporary: tempVectorIndex.
	self internalPush: (self fetchPointer: index ofObject: tempVector)