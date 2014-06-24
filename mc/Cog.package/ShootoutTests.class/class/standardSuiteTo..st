benchmark scripts
standardSuiteTo: aStream
	"revised up from
		{ [self nbody: 200000 to: stream].
		   [self binarytrees: 15 to: stream].
		   [self chameneosredux: 260000 to: stream].
		   [self threadring: 10000000 to: stream] }
	 on 6/15/2014"
	| reference nbodyCount binaryTreeDepth chameneosCount threadringCount |
	reference := self referenceTimesAndArgsForClosureInterpreter.
	nbodyCount := (reference at: #nbody) last.
	binaryTreeDepth := (reference at: #binarytrees) last.
	chameneosCount := (reference at: #chameneosredux) last.
	threadringCount := (reference at: #threadring) last.
	^{ [self nbody: nbodyCount to: aStream].
	     [self binarytrees: binaryTreeDepth to: aStream].
	     [self chameneosredux: chameneosCount to: aStream].
	     [self threadring: threadringCount to: aStream] }