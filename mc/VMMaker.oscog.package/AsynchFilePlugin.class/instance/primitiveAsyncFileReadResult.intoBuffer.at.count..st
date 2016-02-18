primitives
primitiveAsyncFileReadResult: fhandle intoBuffer: buffer at: start count: num 
	| bufferSize bufferPtr r f count startIndex |
	<var: #f type: 'AsyncFile *'>
	self primitive: 'primitiveAsyncFileReadResult' parameters: #(Oop Oop SmallInteger SmallInteger ).

	f := self asyncFileValueOf: fhandle.
	count := num.
	startIndex := start.
	bufferSize := interpreterProxy slotSizeOf: buffer. "in bytes or words"
	(interpreterProxy isWords: buffer) ifTrue: "covert word counts to byte counts"
		[count := count * 4.
		 startIndex := startIndex - 1 * 4 + 1.
		 bufferSize := bufferSize * 4].
	interpreterProxy success: (startIndex >= 1 and: [startIndex + count - 1 <= bufferSize]).

	interpreterProxy failed ifTrue: [^nil].
	"adjust for zero-origin indexing"
	bufferPtr := (self cCoerce: (interpreterProxy firstIndexableField: buffer) to:#sqInt) + startIndex - 1.
	r := self asyncFile: f Read: bufferPtr asVoidPointer Result: count.
	^r asOop: SmallInteger