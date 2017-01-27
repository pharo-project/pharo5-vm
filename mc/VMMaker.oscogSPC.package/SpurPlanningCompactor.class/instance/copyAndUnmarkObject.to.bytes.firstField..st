compaction
copyAndUnmarkObject: o to: toFinger bytes: bytes firstField: firstField
	"Copy the object to toFinger, clearing its mark bit and restoring its firstField, which was overwritten with a forwarding pointer.
	 Answer the number of bytes in the object, including overflow header."
	<inline: true>
	| numSlots destObj start |
	numSlots := manager rawNumSlotsOf: o.
	destObj := (manager objectWithRawSlotsHasOverflowHeader: numSlots)
					ifTrue: [toFinger + manager baseHeaderSize]
					ifFalse: [toFinger].
	start := manager startOfObject: o given: numSlots.
	"memmove must be used since the ranges may overlap."
	manager
		mem: toFinger asVoidPointer mo: start asVoidPointer ve: bytes;
		setIsMarkedOf: destObj to: false;
		storePointerUnchecked: 0 ofObject: destObj withValue: firstField