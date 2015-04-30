class table
enterIntoClassTable: aBehavior
	"Enter aBehavior into the class table and answer 0.  Otherwise answer a primitive failure code."
	<inline: false>
	| initialMajorIndex majorIndex minorIndex page |
	majorIndex := classTableIndex >> self classTableMajorIndexShift.
	initialMajorIndex := majorIndex.
	"classTableIndex should never index the first page; it's reserved for known classes"
	self assert: initialMajorIndex > 0.
	minorIndex := classTableIndex bitAnd: self classTableMinorIndexMask.

	[page := self fetchPointer: majorIndex ofObject: hiddenRootsObj.
	 page = nilObj ifTrue:
		[page := self allocateSlotsInOldSpace: self classTablePageSize
					format: self arrayFormat
					classIndex: self arrayClassIndexPun.
		 page ifNil:
			[^PrimErrNoMemory].
		 self fillObj: page numSlots: self classTablePageSize with: nilObj.
		 self storePointer: majorIndex
			ofObject: hiddenRootsObj
			withValue: page.
		 numClassTablePages := numClassTablePages + 1.
		 minorIndex := 0].
	 minorIndex to: self classTablePageSize - 1 do:
		[:i|
		(self fetchPointer: i ofObject: page) = nilObj ifTrue:
			[classTableIndex := majorIndex << self classTableMajorIndexShift + i.
			 "classTableIndex must never index the first page, which is reserved for classes known to the VM."
			 self assert: classTableIndex >= (1 << self classTableMajorIndexShift).
			 self storePointer: i
				ofObject: page
				withValue: aBehavior.
			 self setHashBitsOf: aBehavior to: classTableIndex.
			 self assert: (self classAtIndex: (self rawHashBitsOf: aBehavior)) = aBehavior.
			 ^0]].
	 majorIndex := (majorIndex + 1 bitAnd: self classIndexMask) max: 1.
	 majorIndex = initialMajorIndex ifTrue: "wrapped; table full"
		[^PrimErrLimitExceeded]] repeat