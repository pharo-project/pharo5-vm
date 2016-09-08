gc -- compaction
objectAfterWhileForwarding: oop
	"Return the oop of the object after the given oop when the actual header of the oop may be in the forwarding table."

	| header fwdBlock realHeader sz |
	<inline: true>
	header := self longAt: oop.
	(header bitAnd: MarkBit) = 0 ifTrue: [ ^ self objectAfter: oop ].  "oop not forwarded"

	"Assume: mark bit cannot be set on a free chunk, so if we get here,
	 oop is not free and it has a forwarding table entry"

	fwdBlock := (header bitAnd: AllButMarkBitAndTypeMask) << 1.
	self assert: (self fwdBlockValid: fwdBlock).
	realHeader := self longAt: fwdBlock + self wordSize.
	"following code is like sizeBitsOf:"
	(realHeader bitAnd: TypeMask) = HeaderTypeSizeAndClass
		ifTrue: [ sz := (self sizeHeader: oop) bitAnd: LongSizeMask ]
		ifFalse: [ sz := realHeader bitAnd: SizeMask ].

	^ self oopFromChunk: (oop + sz)