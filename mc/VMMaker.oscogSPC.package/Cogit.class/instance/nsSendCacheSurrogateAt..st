simulation only
nsSendCacheSurrogateAt: address
	<doNotGenerate>
	self assert: (address < 0 or: [(address bitAnd: objectMemory wordSize - 1) = 0]).
	^nsSendCacheSurrogateClass new
		at: address
		objectMemory: objectMemory
		cogit: self