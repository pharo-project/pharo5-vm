testing
expectedFailures
	(thisContext method respondsTo: #usesAlternateBytecodeSet) ifTrue:
		[^#()].
	^#(testDuplicateNewsqueakV4Methods)