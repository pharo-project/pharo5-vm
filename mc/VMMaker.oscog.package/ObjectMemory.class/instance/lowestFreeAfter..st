garbage collection
lowestFreeAfter: chunk 
	"Return the first free block after the given chunk in memory."
	| oop oopHeader oopHeaderType oopSize |
	<inline: false>
	oop := self oopFromChunk: chunk.
	[self oop: oop isLessThan: endOfMemory] whileTrue:
		[oopHeader := self baseHeader: oop.
		 oopHeaderType := oopHeader bitAnd: TypeMask.
		 oopHeaderType = HeaderTypeFree ifTrue:
			[^oop].
		 oopHeaderType = HeaderTypeSizeAndClass
			ifTrue: [oopSize := (self sizeHeader: oop) bitAnd: AllButTypeMask]
			ifFalse: [oopSize := oopHeader bitAnd: SizeMask].
		 oop := self oopFromChunk: oop + oopSize].
	self error: 'expected to find at least one free object'.
	^nil