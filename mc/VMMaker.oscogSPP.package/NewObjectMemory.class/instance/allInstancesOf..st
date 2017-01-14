primitive support
allInstancesOf: aBehavior
	"Attempt to answer all instances of aBehavior, failing if there is not enough room."
	| count container fillPointer obj byteSize afterPreAllocatedObject |
	"Allocate a large header Array of sufficient size to require a large header.
	 Reset its size later."
	container := self instantiateClass: (self splObj: ClassArray) indexableSize: self minLargeHeaderSize.
	self sizeHeader: container putBodySize: 0.
	afterPreAllocatedObject := freeStart.
	freeStart := fillPointer := (self firstFixedField: container) asInteger.
	count := 0.
	obj := self firstObject.
	[self oop: obj isLessThan: container] whileTrue:
		[(self isFreeObject: obj) ifFalse:
			[(self fetchClassOfNonImm: obj) = aBehavior ifTrue:
				[count := count + 1.
				 fillPointer < reserveStart ifTrue:
					[self longAt: fillPointer put: obj.
					 fillPointer := fillPointer + self bytesPerOop]]].
		 obj := self accessibleObjectAfter: obj].
	fillPointer >= reserveStart ifTrue: "didn't fit.  refill with allocation check pattern and answer count."
		[self maybeFillWithAllocationCheckFillerFrom: freeStart to: fillPointer.
		 ^self integerObjectOf: count].
	byteSize := fillPointer - (self firstFixedField: container) asInteger.
	self sizeHeader: container putBodySize: byteSize.
	"Need to refill with the allocation check pattern if we shortened the object."
	fillPointer < afterPreAllocatedObject ifTrue:
		[self maybeFillWithAllocationCheckFillerFrom: fillPointer to: afterPreAllocatedObject].
	freeStart := fillPointer.
	^container