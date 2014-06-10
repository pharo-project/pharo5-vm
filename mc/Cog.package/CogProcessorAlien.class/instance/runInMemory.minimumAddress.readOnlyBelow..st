execution
runInMemory: aMemory minimumAddress: minimumAddress readOnlyBelow: minimumWritableAddress
"Note that minimumWritableAddress is both the minimum writeable address AND the maximum executable address"
	| result |
	result := self primitiveRunInMemory: aMemory
				minimumAddress: minimumAddress
				readOnlyBelow: minimumWritableAddress.
	result ~~ self ifTrue:
		[self error: 'eek!']