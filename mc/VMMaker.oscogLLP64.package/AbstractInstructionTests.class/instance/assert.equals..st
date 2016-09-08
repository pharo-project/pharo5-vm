accessing
assert: expected equals: actual
	"Override to use a case-insensitive comparison for strings."
	^self
		assert: (expected isString
				ifTrue: [expected sameAs: actual]
				ifFalse: [expected = actual])
		description: [ self comparingStringBetween: expected and: actual ]
