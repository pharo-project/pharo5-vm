primitives
primitiveAsyncFileWriteStart: fHandle fPosition: fPosition fromBuffer: buffer at: start count: num 
	| f bufferSize bufferPtr count startIndex |
	<var: #f type: 'AsyncFile *'>
	self primitive: 'primitiveAsyncFileWriteStart' parameters: #(Oop SmallInteger Oop SmallInteger SmallInteger ).
	f := self asyncFileValueOf: fHandle.
	count := num.
	startIndex := start.
	bufferSize := interpreterProxy slotSizeOf: buffer.	"in bytes or words"
	(interpreterProxy isWords: buffer) ifTrue: "covert word counts to byte counts"
		[count := count * 4.
		 startIndex := startIndex - 1 * 4 + 1.
		 bufferSize := bufferSize * 4].
	interpreterProxy success: (startIndex >= 1 and: [startIndex + count - 1 <= bufferSize]).

	interpreterProxy failed ifTrue: [^nil].
	"adjust for zero-origin indexing"
	bufferPtr := (self cCoerce: (interpreterProxy firstIndexableField: buffer) to: #sqInt) + startIndex - 1.
	self async: f File: fPosition Write: bufferPtr asVoidPointer Start: count