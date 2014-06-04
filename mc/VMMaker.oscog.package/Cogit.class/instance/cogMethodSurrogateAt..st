simulation only
cogMethodSurrogateAt: address
	<doNotGenerate>
	self assert: (address bitAnd: BytesPerWord - 1) = 0.
	^cogMethodSurrogateClass new
		at: address
		objectMemory: objectMemory
		cogit: self