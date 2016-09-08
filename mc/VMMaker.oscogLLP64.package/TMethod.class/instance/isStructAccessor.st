testing
isStructAccessor
	^[definingClass isAccessor: selector]
		on: MessageNotUnderstood
		do: [:ex| false]