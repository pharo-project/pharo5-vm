object access
byteSizeOf: oop
	"Return the size of the receiver in bytes"
	^oop class isBytes
		ifTrue:[(self slotSizeOf: oop)]
		ifFalse:[(self slotSizeOf: oop) * 4]