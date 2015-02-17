type inference
typeForDereference: sendNode in: aTMethod
	| type |
	type := self typeFor: sendNode receiver in: aTMethod.
	type last = $* ifTrue:
		[^type allButLast withBlanksTrimmed].
	self error: 'cannot determine type'.
	^nil