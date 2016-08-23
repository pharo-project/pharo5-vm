object access
storePointerUnchecked: fieldIndex ofMaybeForwardedObject: objOop withValue: valuePointer
	^self
		longAt: objOop + self baseHeaderSize + (fieldIndex << self shiftForWord)
		put: valuePointer