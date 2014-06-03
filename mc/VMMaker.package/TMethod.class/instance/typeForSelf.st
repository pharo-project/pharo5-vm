utilities
typeForSelf
	self assert: definingClass notNil.
	^[definingClass typeForSelf]
		on: MessageNotUnderstood
		do: [:ex| nil]