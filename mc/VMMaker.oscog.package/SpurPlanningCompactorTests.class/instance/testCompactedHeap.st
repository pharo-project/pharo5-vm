tests
testCompactedHeap
	"First test for valid compactibility of an already compacted heap via fullGC"
	| freeSpace om |
	om := self initializedVM objectMemory.
	freeSpace := om bytesLeftInOldSpace.
	om fullGC.
	self assert: freeSpace equals: om bytesLeftInOldSpace.
	self checkForLeaksIn: om.
	om fullGC.
	self assert: freeSpace equals: om bytesLeftInOldSpace.
	self checkForLeaksIn: om