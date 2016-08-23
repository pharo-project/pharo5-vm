accessing
annotation: aByte
	self assert: (annotation isNil or: [annotation = aByte]).
	^annotation := aByte