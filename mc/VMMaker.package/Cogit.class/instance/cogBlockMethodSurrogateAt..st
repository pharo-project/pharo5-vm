simulation only
cogBlockMethodSurrogateAt: address
	<doNotGenerate>
	self assert: (address bitAnd: BytesPerWord - 1) = 0.
	^cogBlockMethodSurrogateClass new
		at: address
		objectMemory: objectMemory
		cogit: self