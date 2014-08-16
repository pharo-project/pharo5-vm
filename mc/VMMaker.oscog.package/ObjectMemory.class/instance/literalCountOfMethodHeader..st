memory access
literalCountOfMethodHeader: header
	<inline: true>
	self assert: (self isIntegerObject: header).
	^header >> 10 bitAnd: 16rFF