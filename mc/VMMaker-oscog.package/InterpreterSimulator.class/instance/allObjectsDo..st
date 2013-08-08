debug support
allObjectsDo: objBlock

	| oop |
	oop := self firstObject.
	[oop < endOfMemory] whileTrue:
			[(self isFreeObject: oop)
				ifFalse: [objBlock value: oop].
			oop := self objectAfter: oop].
