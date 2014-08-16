method access
literalCountOfMethodHeader: header
	self assert: (self isIntegerObject: header).
	^header >> 10 bitAnd: 16rFF