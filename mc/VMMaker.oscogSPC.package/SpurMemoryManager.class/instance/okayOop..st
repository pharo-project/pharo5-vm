debug support
okayOop: signedOop
	"Verify that the given oop is legitimate. Check address, header, and size but not class."

	| oop classIndex fmt unusedBits unusedBitsInYoungObjects |
	<var: #oop type: #usqInt>
	<var: #unusedBits type: #usqLong>
	oop := self cCoerce: signedOop to: #usqInt.

	"address and size checks"
	(self isImmediate: oop) ifTrue: [^true].
	(self addressCouldBeObj: oop) ifFalse:
		[self error: 'oop is not a valid address'. ^false].

	(self oop: (self addressAfter: oop) isLessThanOrEqualTo: endOfMemory) ifFalse:
		[self error: 'oop size would make it extend beyond the end of memory'. ^false].

	"header type checks"
	(classIndex := self classIndexOf: oop) >= self firstClassIndexPun ifFalse:
		[self error: 'oop is a free chunk, or bridge, not an object'. ^false].
	((self rawNumSlotsOf: oop) = self numSlotsMask
	 and: [(self rawNumSlotsOf: oop - self baseHeaderSize) ~= self numSlotsMask]) ifTrue:
		[self error: 'oop header has overflow header word, but overflow word does not have a saturated numSlots field'. ^false].

	"format check"
	fmt := self formatOf: oop.
	(fmt = 6) | (fmt = 8) ifTrue:
		[self error: 'oop has an unknown format type'. ^false].
	(fmt = self forwardedFormat) ~= (classIndex = self isForwardedObjectClassIndexPun) ifTrue:
		[self error: 'oop has mis-matched format/classIndex fields; only one of them is the isForwarded value'. ^false].

	"specific header bit checks"
	unusedBits := (1 << self classIndexFieldWidth)
				   bitOr: (1 << (self identityHashFieldWidth + 32)).
	((self long64At: oop) bitAnd: unusedBits) ~= 0 ifTrue:
		[self error: 'some unused header bits are set; should be zero'. ^false].

	unusedBitsInYoungObjects := ((1 << self greyBitShift)
								   bitOr: (1 << self pinnedBitShift))
								   bitOr: (1 << self rememberedBitShift).
	((self longAt: oop) bitAnd: unusedBitsInYoungObjects) ~= 0 ifTrue:
		[self error: 'some header bits unused in young objects are set; should be zero'. ^false].
	^true
