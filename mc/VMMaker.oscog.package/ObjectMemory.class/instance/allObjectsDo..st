object enumeration
allObjectsDo: aBlock
	<inline: true>
	| oop |
	oop := self firstObject.
	[oop < freeBlock] whileTrue:
		[(self isFreeObject: oop) ifFalse:
			[aBlock value: oop].
		 oop := self objectAfter: oop]