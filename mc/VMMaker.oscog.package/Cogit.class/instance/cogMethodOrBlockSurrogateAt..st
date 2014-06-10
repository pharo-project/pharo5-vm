simulation only
cogMethodOrBlockSurrogateAt: address
	<doNotGenerate>
	| surrogate |
	surrogate := self cogMethodSurrogateAt: address.
	^surrogate cmType = CMBlock
		ifTrue: [self cogBlockMethodSurrogateAt: address]
		ifFalse: [surrogate]