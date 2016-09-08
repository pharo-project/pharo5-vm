rcvr linkage
allocateByteArrayAndSetRcvrExtraPtrFrom: anExtraPtr

	| extraObject extraByteArrayPtr |
	<var: #extraByteArrayPtr type: 'void *'>

	anExtraPtr
		ifFalse: [extraObject := interpreterProxy nilObject]
		ifTrue: [
			"Allocate a Smalltalk ByteArray -- lastAlloc contains the length"
			extraObject := interpreterProxy
						instantiateClass: (interpreterProxy classByteArray) 
						indexableSize: (self cCode: 'sizeof(real_pcre_extra)').
			self loadRcvrFromStackAt: 0. "Assume garbage collection after instantiation"

			"Copy from the C bytecode buffer to the Smalltalk ByteArray"
			extraByteArrayPtr := interpreterProxy arrayValueOf: extraObject.	
			self cCode:'memcpy(extraByteArrayPtr, (void *) anExtraPtr, sizeof(real_pcre_extra))'].
 
	"Set rcvrErrorStr from errorStr and Return"
	self rcvrExtraPtrFrom: extraObject.
	self touch: extraByteArrayPtr.	
	^extraObject.
