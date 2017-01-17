interpreter access
storePointerUnchecked: index ofObject: oop withValue: valuePointer
	"Override to ensure acess is within the heap, and within the object"
	| fmt hdr |
	self assert: oop >= self startOfMemory.
	hdr := self baseHeader: oop.
	fmt := self formatOfHeader: hdr.
	self assert: ((fmt <= self lastPointerFormat or: [fmt >= self firstCompiledMethodFormat])
				and: [index >= 0 and: [index < (self lengthOf: oop baseHeader: hdr format: fmt)]]).
	^super storePointerUnchecked: index ofObject: oop withValue: valuePointer