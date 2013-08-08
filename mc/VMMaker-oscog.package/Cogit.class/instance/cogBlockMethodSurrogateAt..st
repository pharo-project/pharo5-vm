simulation only
cogBlockMethodSurrogateAt: address
	<doNotGenerate>
	self assert: (address bitAnd: BytesPerWord - 1) = 0.
	^cogBlockMethodSurrogateClass new
		at: address
		memory: objectMemory memory
		cogit: self