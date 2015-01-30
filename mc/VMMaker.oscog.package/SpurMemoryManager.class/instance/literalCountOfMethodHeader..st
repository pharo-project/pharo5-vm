method access
literalCountOfMethodHeader: header
	<api>
	<inline: true>
	self assert: (self isIntegerObject: header).
	^coInterpreter literalCountOfAlternateHeader: header