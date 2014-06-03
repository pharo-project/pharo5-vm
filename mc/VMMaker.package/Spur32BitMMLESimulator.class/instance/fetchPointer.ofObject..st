object access
fetchPointer: fieldIndex ofObject: objOop
	self assert: (self isForwarded: objOop) not.
	self assert: (fieldIndex >= 0 and: [fieldIndex < (self numSlotsOfAny: objOop)
				or: [fieldIndex = 0 "forwarders and free objs"]]).
	^super fetchPointer: fieldIndex ofObject: objOop