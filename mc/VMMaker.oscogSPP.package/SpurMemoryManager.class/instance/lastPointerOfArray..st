object enumeration
lastPointerOfArray: objOop 
	"Answer the byte offset of the last pointer field of the given array."
	self assert: (self isArray: objOop).
	^(self numSlotsOf: objOop) - 1 * self bytesPerOop + self baseHeaderSize