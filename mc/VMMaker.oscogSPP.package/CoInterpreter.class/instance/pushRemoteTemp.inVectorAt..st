stack bytecodes
pushRemoteTemp: index inVectorAt: tempVectorIndex
	"Override to use itemporary:in:put:"
	| tempVector |
	tempVector := self itemporary: tempVectorIndex in: localFP.
	self internalPush: (objectMemory fetchPointer: index ofObject: tempVector)