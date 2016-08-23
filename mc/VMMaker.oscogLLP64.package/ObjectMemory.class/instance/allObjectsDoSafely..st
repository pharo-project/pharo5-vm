object enumeration
allObjectsDoSafely: aBlock
	<inline: true>
	| oop |
	oop := self firstObject.
	[oop asUnsignedInteger < freeBlock] whileTrue:
		[(self isFreeObject: oop) ifFalse:
			[aBlock value: oop].
		 oop := self objectAfterWhileForwarding: oop]