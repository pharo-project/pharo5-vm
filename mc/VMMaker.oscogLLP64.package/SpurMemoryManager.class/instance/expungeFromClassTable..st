class table
expungeFromClassTable: aBehavior
	"Remove aBehavior from the class table."
	<inline: false>
	| classIndex majorIndex minorIndex classTablePage |
	self assert: (self isInClassTable: aBehavior).
	classIndex := self rawHashBitsOf: aBehavior.
	majorIndex := classIndex >> self classTableMajorIndexShift.
	minorIndex := classIndex bitAnd: self classTableMinorIndexMask.
	classTablePage := self fetchPointer: majorIndex ofObject: hiddenRootsObj.
	self assert: classTablePage ~= classTableFirstPage.
	self assert: (self numSlotsOf: classTablePage) = self classTablePageSize.
	self assert: (self fetchPointer: minorIndex ofObject: classTablePage) = aBehavior.
	self storePointerUnchecked: minorIndex ofObject: classTablePage withValue: nilObj.
	"If the removed class is before the classTableIndex, set the
	 classTableIndex to point to the empty slot so as to reuse it asap."
	classIndex < classTableIndex ifTrue:
		[classTableIndex := classIndex].
	"classTableIndex must never index the first page, which is reserved for classes known to the VM."
	self assert: classTableIndex >= (1 << self classTableMajorIndexShift)