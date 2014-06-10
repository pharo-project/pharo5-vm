as yet unclassified
assertValidExecutionPointers
	| spidx |
	self assert: (self validInstructionPointer: localIP inMethod: method).
	spidx := self stackPointerIndexFor: localSP context: activeContext.
	self assert: (spidx >= -1 and: [spidx < (self lengthOf: activeContext)])