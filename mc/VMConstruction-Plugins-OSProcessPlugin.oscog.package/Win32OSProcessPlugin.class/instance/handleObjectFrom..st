private - handle conversion
handleObjectFrom: aHandle
	"Answer an object which contains the value of a HANDLE."
 
	| handleUnion handleOop ptr idx |
	<var: 'aHandle' type: #HANDLE>
	<var: 'ptr' type: #'unsigned char *'>
	<var: 'handleUnion' type: 'union {HANDLE handle; char bytes[sizeof(HANDLE)];}'>
	self cCode: 'handleUnion.handle = aHandle'.
	handleOop := interpreterProxy
					instantiateClass: interpreterProxy classByteArray
					indexableSize: (self sizeof: #HANDLE).
	ptr := interpreterProxy arrayValueOf: handleOop.
	idx := 0.
	[idx < (self sizeof: #HANDLE)] whileTrue:
		[self cCode: 'ptr[idx]= handleUnion.bytes[idx]'.
		idx := idx + 1].
	^handleOop