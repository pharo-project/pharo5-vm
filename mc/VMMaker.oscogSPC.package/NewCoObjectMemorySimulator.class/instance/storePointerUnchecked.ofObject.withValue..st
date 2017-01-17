interpreter access
storePointerUnchecked: fieldIndex ofObject: oop withValue: valuePointer
	"Override to ensure acess is within the heap, and within the object"
	| fmt hdr |
	self assert: oop >= self startOfMemory.
	hdr := self baseHeader: oop.
	fmt := self formatOfHeader: hdr.
	self assert: ((fmt <= 4 or: [fmt >= 12])
				and: [fieldIndex >= 0 and: [fieldIndex < (self lengthOf: oop baseHeader: hdr format: fmt)]]).
	self assert: oop + self baseHeaderSize + (fieldIndex << self shiftForWord) < freeStart.
	^super storePointerUnchecked: fieldIndex ofObject: oop withValue: valuePointer