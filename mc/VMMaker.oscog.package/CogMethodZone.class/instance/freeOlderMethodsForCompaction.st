compaction
freeOlderMethodsForCompaction
	"Free methods, preferring older methods for compaction, up to some fraction, currently a quarter."
	| zoneSize amountToFree initialFreeSpace freedSoFar freeableUsage cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	zoneSize := limitAddress - baseAddress.
	initialFreeSpace := limitAddress - mzFreeStart + methodBytesFreedSinceLastCompaction.
	freedSoFar := initialFreeSpace.
	amountToFree := zoneSize // 4. "4 needs to be e.g. a start-up parameter"
	freeableUsage := 0.
	[self cCode: ''
		inSmalltalk: [coInterpreter transcript nextPutAll: 'freeing methods with usage '; print: freeableUsage; cr; flush].
	 cogMethod := cogit cCoerceSimple: baseAddress to: #'CogMethod *'.
	 [cogMethod asUnsignedInteger < mzFreeStart
	  and: [freedSoFar < amountToFree]] whileTrue:
		[(self shouldFreeMethod: cogMethod given: freeableUsage) ifTrue:
			[self freeMethod: cogMethod.
			 freedSoFar := freedSoFar + cogMethod blockSize].
		 cogMethod := self methodAfter: cogMethod].
	 freedSoFar < amountToFree
	 and: [(freeableUsage := freeableUsage + 1) < CMMaxUsageCount]] whileTrue.
	self cCode: ''
		inSmalltalk: [coInterpreter transcript
						nextPutAll: 'Compaction freeing '; print: freedSoFar;
						nextPutAll: ' of '; print: zoneSize;
						nextPutAll: ' (target: '; print: amountToFree;
						nextPutAll: ' (newly freed: '; print: freedSoFar - initialFreeSpace;
						cr; flush]