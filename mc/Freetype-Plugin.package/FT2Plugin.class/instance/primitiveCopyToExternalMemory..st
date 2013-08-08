private
primitiveCopyToExternalMemory: aByteArray
	| rcvr byteSize aPointer |
	rcvr := self primitive: 'primitiveCopyToExternalMemory'
		parameters: #(ByteArray)
		receiver: #FreeTypeExternalMemory.
	self touch: rcvr.

	self var: #byteSize type: 'size_t'.
	self var: #aPointer declareC: 'void *aPointer'.
	errorCode := 0.

	byteSize := interpreterProxy byteSizeOf: aByteArray cPtrAsOop.
	self touch: byteSize.
	interpreterProxy failed ifTrue: [ ^nil ].

	aPointer := self cCode: 'malloc(byteSize)'.
	self cCode: 'memcpy(aPointer,aByteArray,byteSize)'.

	self ftAllocateHandleInReceiverForPointer: aPointer
