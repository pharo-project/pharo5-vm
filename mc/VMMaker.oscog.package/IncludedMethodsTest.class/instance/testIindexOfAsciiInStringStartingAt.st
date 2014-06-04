testing - MiscPrimitivePlugin
testIindexOfAsciiInStringStartingAt

	| position |
	position := self indexOfAscii: 50 inString: '012345' startingAt: 1.
	self assert: position = 3