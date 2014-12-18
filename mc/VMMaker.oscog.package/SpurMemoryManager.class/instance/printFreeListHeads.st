debug printing
printFreeListHeads
	<api>
	| expectedMask |
	expectedMask := 0.
	0 to: self numFreeLists - 1 do:
		[:i|
		coInterpreter printHex: (freeLists at: i).
		(freeLists at: i) ~= 0 ifTrue:
			[expectedMask := expectedMask + (1 << i)].
		i \\ (32 >> self logBytesPerOop) = 0
			ifTrue: [coInterpreter cr]
			ifFalse: [coInterpreter tab]].
	coInterpreter
		print: 'mask: '; printHex: freeListsMask;
		print: ' expected: '; printHex: expectedMask;
		cr