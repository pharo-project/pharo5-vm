method access
literalCountOfMethodHeader: header
	<api>
	<inline: true>
	self assert: (self isIntegerObject: header).
	^(self integerValueOf: header) bitAnd: 16rFFFF