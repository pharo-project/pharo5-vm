primitives - nonblocking read
primitiveBufferValuesAt
	"For debugging only. Answer the current values of readCharBufferArray,
	readCharCountArray, and readCharStatusArray at index, an integer corresponding
	to a semaphore for one read handler thread. Answer an Array with the buffered
	character, the character count, and the status value."

	| index result byte count status |
	<export: true>
	<var: 'byte' type: 'unsigned char'>
	<var: 'count' type: 'DWORD'>
	<var: 'status' type: 'int'>
	index := interpreterProxy stackIntegerValue: 0.
	byte := readCharBufferArray at: index.
	count := readCharCountArray at: index.
	status := readCharStatusArray at: index.
	result := interpreterProxy
		instantiateClass: interpreterProxy classArray
		indexableSize: 3.
	interpreterProxy
		storePointer: 0
		ofObject: result
		withValue: (interpreterProxy positive32BitIntegerFor: byte).
	interpreterProxy
		storePointer: 1
		ofObject: result
		withValue: (interpreterProxy positive32BitIntegerFor: count).
	interpreterProxy
		storePointer: 2
		ofObject: result
		withValue: (interpreterProxy positive32BitIntegerFor: status).
	interpreterProxy pop: 2 thenPush: result
