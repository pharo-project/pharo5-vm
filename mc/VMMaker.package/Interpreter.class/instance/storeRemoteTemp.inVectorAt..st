stack bytecodes
storeRemoteTemp: index inVectorAt: tempVectorIndex
	| tempVector |
	tempVector := self temporary: tempVectorIndex.
	self storePointer: index ofObject: tempVector withValue: self internalStackTop.