memory access
literalCountOfMethodHeader: methodHeader
	<api>
	<inline: true>
	self assert: (self isIntegerObject: methodHeader).
	^(self headerIndicatesAlternateBytecodeSet: methodHeader)
		ifTrue: [coInterpreter literalCountOfAlternateHeader: methodHeader]
		ifFalse: [coInterpreter literalCountOfOriginalHeader: methodHeader]