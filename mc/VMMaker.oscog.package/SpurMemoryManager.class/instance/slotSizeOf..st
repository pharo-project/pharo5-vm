object access
slotSizeOf: oop
	"*DO NOT CONFUSE THIS WITH numSlotsOf:.
	 This is an ObjectMemory compatibility method with questionable semantics.
	 Answers the number of slots in the receiver.
	 If the receiver is a byte object, return the number of bytes.
	 Otherwise return the number of words."
	(self isImmediate: oop) ifTrue: [^0].
	^self lengthOf: oop