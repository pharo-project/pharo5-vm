debug support
checkOkayOop: oop
	"Verify that the given oop is legitimate. Check address, header, and size but not class.
	 Answer true if OK.  Otherwise print reason and answer false."
	<api>
	<var: #oop type: #usqInt>
	| classIndex fmt unusedBits unusedBitsInYoungObjects |
	<var: #unusedBits type: #usqLong>

	"address and size checks"
	(self isImmediate: oop) ifTrue: [^true].
	(self addressCouldBeObj: oop) ifFalse:
		[self print: 'oop '; printHex: oop; print: ' is not a valid address'. ^false].

	(self oop: (self addressAfter: oop) isLessThanOrEqualTo: endOfMemory) ifFalse:
		[self print: 'oop '; printHex: oop; print: ' size would make it extend beyond the end of memory'. ^false].

	"header type checks"
	(classIndex := self classIndexOf: oop) >= self firstClassIndexPun ifFalse:
		[self print: 'oop '; printHex: oop; print: ' is a free chunk, or bridge, not an object'. ^false].
	((self rawNumSlotsOf: oop) = self numSlotsMask
	 and: [(self rawNumSlotsOf: oop - self baseHeaderSize) ~= self numSlotsMask]) ifTrue:
		[self print: 'oop '; printHex: oop; print: ' header has overflow header word, but overflow word does not have a saturated numSlots field'. ^false].

	"format check"
	fmt := self formatOf: oop.
	(fmt = 6) | (fmt = 8) ifTrue:
		[self print: 'oop '; printHex: oop; print: ' has an unknown format type'. ^false].
	(fmt = self forwardedFormat) ~= (classIndex = self isForwardedObjectClassIndexPun) ifTrue:
		[self print: 'oop '; printHex: oop; print: ' has mis-matched format/classIndex fields; only one of them is the isForwarded value'. ^false].

	"specific header bit checks"
	unusedBits := (1 << self classIndexFieldWidth)
				   bitOr: (1 << (self identityHashFieldWidth + 32)).
	((self long64At: oop) bitAnd: unusedBits) ~= 0 ifTrue:
		[self print: 'oop '; printHex: oop; print: ' has some unused header bits set; should be zero'. ^false].

	unusedBitsInYoungObjects := self newSpaceRefCountMask.
	((self longAt: oop) bitAnd: unusedBitsInYoungObjects) ~= 0 ifTrue:
		[self print: 'oop '; printHex: oop; print: ' has some header bits unused in young objects set; should be zero'. ^false].
	^true