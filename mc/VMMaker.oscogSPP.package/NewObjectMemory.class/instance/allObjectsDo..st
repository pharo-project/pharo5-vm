object enumeration
allObjectsDo: aBlock
	<inline: true>
	| oop |
	oop := self firstObject.
	[oop asUnsignedInteger < freeStart] whileTrue:
		[(self isFreeObject: oop) ifFalse:
			[aBlock value: oop].
		 oop := self objectAfter: oop]