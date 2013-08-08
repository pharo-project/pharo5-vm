private
ftAllocateStringForPointer: aPointer
	"given NUL-terminated char* aPointer (returned from a library call), 
	return the oop for a String containing the pointer's bytes"
	| returnedHandle extraByteArrayPtr |
	self var: #extraByteArrayPtr declareC: 'char *extraByteArrayPtr'.
	self var: #aPointer declareC: 'const char *aPointer'.
	aPointer
		ifTrue: ["Allocate a Smalltalk ByteArray -- lastAlloc contains the length"
			returnedHandle := interpreterProxy
						instantiateClass: interpreterProxy classString
						indexableSize: (self cCode: 'strlen(aPointer)').
			"Copy from the C bytecode buffer to the Smalltalk ByteArray"
			extraByteArrayPtr := interpreterProxy arrayValueOf: returnedHandle.
			self touch: extraByteArrayPtr.
			self cCode: 'strncpy(extraByteArrayPtr, aPointer, strlen(aPointer))']
		ifFalse: [returnedHandle := interpreterProxy nilObject].
	^ returnedHandle