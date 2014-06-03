object enumeration
startOfObject: objOop
	"Answer the start of objOop, which is either the address of the overflow
	 size word, or objOop itself, depending on the size of the object.  This may
	 be applied to any kind of object, normal, forwarders or free chunks."
	^(self hasOverflowHeader: objOop)
		ifTrue: [objOop - self baseHeaderSize]
		ifFalse: [objOop]