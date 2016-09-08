primitive support
unmarkAllObjects
	| oop hdr |
	oop := self firstObject.
	[oop asUnsignedInteger < freeStart] whileTrue:
		[(self isFreeObject: oop) ifFalse:
			[hdr := self baseHeader: oop.
			 (hdr bitAnd: MarkBit) ~= 0 ifTrue:
				[self baseHeader: oop put: (hdr bitAnd: AllButMarkBit)]].
		 oop := self objectAfter: oop]