testing - MiscPrimitivePlugin
testFindFirstInStringInSetStartingAt

	| position set |
	set := ((0 to: 255) collect: [:e | (e \\ 2) + $0 asciiValue]) asByteArray.
	position := self findFirstInString: 'abcdef' inSet: set startingAt: 1.
	self assert: position = 1
