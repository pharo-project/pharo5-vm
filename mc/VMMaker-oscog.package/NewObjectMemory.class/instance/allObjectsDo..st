debug support
allObjectsDo: aBlock
	<doNotGenerate>
	| oop |
	oop := self firstObject.
	[oop < freeStart] whileTrue:
		[(self isFreeObject: oop) ifFalse:
			[aBlock value: oop].
		 oop := self objectAfterWhileForwarding: oop]