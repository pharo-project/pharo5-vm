debugging
sqAssert: aBool 
	self debugCode:
		[aBool ifFalse:
			[self error: 'Assertion failed!']].
	^aBool