object enumeration
startOfObject: objOop given: rawNumSlots
	"Answer the start of objOop, which is either the address of the overflow
	 size word, or objOop itself, depending on the size of the object.  This may
	 be applied to any kind of object, normal, forwarders or free chunks."
	<returnTypeC: #usqInt>
	^(self objectWithRawSlotsHasOverflowHeader: rawNumSlots)
		ifTrue: [objOop - self baseHeaderSize]
		ifFalse: [objOop]