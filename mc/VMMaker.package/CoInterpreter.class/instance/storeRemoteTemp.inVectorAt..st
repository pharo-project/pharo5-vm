stack bytecodes
storeRemoteTemp: index inVectorAt: tempVectorIndex
	"Override to use itemporary:in:put:"
	| tempVector |
	tempVector := self itemporary: tempVectorIndex in: localFP.
	objectMemory storePointer: index ofObject: tempVector withValue: self internalStackTop