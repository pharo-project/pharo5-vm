compiled methods
literalCountOfHeader: headerPointer
	<api>
	^self cppIf: MULTIPLEBYTECODESETS
		ifTrue: [(self headerIndicatesAlternateBytecodeSet: headerPointer)
					ifTrue: [self literalCountOfAlternateHeader: headerPointer]
					ifFalse: [self literalCountOfOriginalHeader: headerPointer]]
		ifFalse: [self literalCountOfOriginalHeader: headerPointer]