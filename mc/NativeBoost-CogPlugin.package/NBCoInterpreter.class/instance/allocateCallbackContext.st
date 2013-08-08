callback support
allocateCallbackContext
<export: true>

	^ self 
		instantiateClass: (self splObj: ClassByteArray)
		indexableSize: (self sizeof: (#VMCallbackContext asSymbol)).
