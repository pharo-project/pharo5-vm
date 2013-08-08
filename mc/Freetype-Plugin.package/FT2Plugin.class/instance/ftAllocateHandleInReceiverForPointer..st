private
ftAllocateHandleInReceiverForPointer: aPointer
	"given aPointer (returned from a library call),
	set the receiver's (bottom of stack) first instance variable
	to a ByteArray containing the pointer's bytes"
	| returnedHandle extraByteArrayPtr |
	self var: #extraByteArrayPtr declareC: 'void **extraByteArrayPtr'.
	self var: #aPointer declareC: 'void *aPointer'.

	aPointer
		ifFalse: [returnedHandle := interpreterProxy nilObject]
		ifTrue: [
			"Allocate a Smalltalk ByteArray -- lastAlloc contains the length"
			returnedHandle := interpreterProxy
						instantiateClass: (interpreterProxy classByteArray) 
						indexableSize: (self cCode: 'sizeof(void **)').
			"Copy from the C bytecode buffer to the Smalltalk ByteArray"
			extraByteArrayPtr := interpreterProxy arrayValueOf: returnedHandle.	
			self cCode: '*extraByteArrayPtr = (void *)(aPointer)' ].
 
	interpreterProxy 
		storePointer: 0
		ofObject: (interpreterProxy stackObjectValue: interpreterProxy methodArgumentCount)
		withValue: returnedHandle.

	self touch: extraByteArrayPtr.	
	^returnedHandle.
