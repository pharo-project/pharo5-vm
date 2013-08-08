interpreter access
storePointer: index ofObject: oop withValue: valuePointer
	"Override to ensure acess is within the heap, and within the object"
	| fmt hdr |
	self assert: oop >= self startOfMemory.
	hdr := self baseHeader: oop.
	fmt := self formatOfHeader: hdr.
	self assert: ((fmt <= 4 or: [fmt >= 12])
				and: [index >= 0 and: [index < (self lengthOf: oop baseHeader: hdr format: fmt)]]).
	^super storePointer: index ofObject: oop withValue: valuePointer