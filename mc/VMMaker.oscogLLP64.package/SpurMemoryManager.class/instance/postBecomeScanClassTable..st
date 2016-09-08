become implementation
postBecomeScanClassTable: effectsFlags
	"Scan the class table post-become (iff an active class object was becommed) to ensure no
	 forwarding pointers, and no unhashed classes exist in the class table.

	 Note that one-way become can cause duplications in the class table.
	 When can these be eliminated?  We use the classTableBitmap to mark classTable entries
	 (not the classes themselves, since marking a class doesn't help in knowing if its index is used).
	 On image load, and during incrememtal scan-mark and full GC, classIndices are marked.
	 We can somehow avoid following classes from the classTable until after this mark phase."
	self assert: self validClassTableRootPages.

	(effectsFlags anyMask: BecamePointerObjectFlag) ifFalse: [^self].

	0 to: numClassTablePages - 1 do:
		[:i| | page |
		page := self fetchPointer: i ofObject: hiddenRootsObj.
		self assert: (self isForwarded: page) not.
		0 to: (self numSlotsOf: page) - 1 do:
			[:j| | classOrNil |
			classOrNil := self fetchPointer: j ofObject: page.
			classOrNil ~= nilObj ifTrue:
				[(self isForwarded: classOrNil) ifTrue:
					[classOrNil := self followForwarded: classOrNil.
					 self storePointer: j ofObject: page withValue: classOrNil].
				 (self rawHashBitsOf: classOrNil) = 0 ifTrue:
					[self storePointerUnchecked: j ofObject: page withValue: nilObj.
					 "If the removed class is before the classTableIndex, set the
					  classTableIndex to point to the empty slot so as to reuse it asap."
					 (i << self classTableMajorIndexShift + j) < classTableIndex ifTrue:
						[classTableIndex := i << self classTableMajorIndexShift + j]]]]].
	"classTableIndex must never index the first page, which is reserved for classes known to the VM."
	self assert: classTableIndex >= (1 << self classTableMajorIndexShift)