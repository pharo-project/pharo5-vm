tests
testIncompactibleHeap
	| errored |
	errored := false.
	"First test for incompactibility via fullGC"
	[self initializedVM objectMemory
		abandonEmptySegmentForTests;
		fullGC]
		on: Error
		do: [:ex|
			errored := true.
			self assert: ex messageText = 'uncompactable heap; no unmarked objects found'].
	self assert: errored.

	"Now check for incompactibility by directly calling compact"
	errored := false.
	"First test for incompactibility via fullGC"
	[| om |
	 om := self initializedVM objectMemory.
	 om abandonEmptySegmentForTests.
	 om allOldSpaceObjectsDo: [:o| om setIsMarkedOf: o to: true].
	 om compactor compact]
		on: Error
		do: [:ex|
			errored := true.
			self assert: ex messageText = 'uncompactable heap; no unmarked objects found'].
	self assert: errored