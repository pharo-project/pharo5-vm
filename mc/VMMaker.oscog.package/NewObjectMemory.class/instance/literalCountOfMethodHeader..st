memory access
literalCountOfMethodHeader: header
	<api>
	<inline: true>
	self assert: (self isIntegerObject: header).
	^(coInterpreter headerIndicatesAlternateBytecodeSet: header)
		ifTrue: [coInterpreter literalCountOfAlternateHeader: header]
		ifFalse: [coInterpreter literalCountOfOriginalHeader: header]