processor setup
initializeStackFor: aCogit
"Different cpus need different stack alignment etc, so handle the details here."
	| stackAlignment |
	stackAlignment := 8.
	aCogit setStackAlignment: stackAlignment expectedSPOffset: 0 expectedFPOffset: 0.
	self assert: stackAlignment isPowerOfTwo.
	PostBuildStackDelta :=  stackAlignment > 8
								ifTrue: [stackAlignment - 8]
								ifFalse: [0]