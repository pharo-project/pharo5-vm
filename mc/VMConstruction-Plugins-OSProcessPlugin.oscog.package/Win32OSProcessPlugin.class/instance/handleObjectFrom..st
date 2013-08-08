private - handle conversion
handleObjectFrom: aHandle
	"Answer an object which contains the value of a HANDLE."
 
	| size handleOop ptr handleUnion idx |
	<var: 'aHandle' type: 'HANDLE'>
	<var: 'ptr' type: 'unsigned char *'>
	<var: 'handleUnion' type: 'union {HANDLE handle; char bytes[sizeof(HANDLE)];}'>
	self cCode: 'handleUnion.handle = aHandle'.
	size := self sizeOfHandle.
	handleOop := interpreterProxy
		instantiateClass: interpreterProxy classByteArray
		indexableSize: size.
	ptr := interpreterProxy arrayValueOf: handleOop.
	idx := 0.
	[idx < size] whileTrue:
		[self cCode: 'ptr[idx]= handleUnion.bytes[idx]'.
		idx := idx + 1].
	^ handleOop
