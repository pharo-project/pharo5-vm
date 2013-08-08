primitives
primitiveAsyncFileReadResult: fhandle intoBuffer: buffer at: start count: num 
	| bufferSize bufferPtr r f count startIndex |
	<var: #f type: 'AsyncFile *'>
	self primitive: 'primitiveAsyncFileReadResult' parameters: #(Oop Oop SmallInteger SmallInteger ).

	f := self asyncFileValueOf: fhandle.
	count := num.
	startIndex := start.
	bufferSize := interpreterProxy slotSizeOf: buffer. "in bytes or words"
	(interpreterProxy isWords: buffer)
		ifTrue: ["covert word counts to byte counts"
			count := count * 4.
			startIndex := startIndex - 1 * 4 + 1.
			bufferSize := bufferSize * 4].
	interpreterProxy success: (startIndex >= 1 and: [startIndex + count - 1 <= bufferSize]).

	bufferPtr := (self cCoerce: (interpreterProxy firstIndexableField: buffer) to: 'int') + startIndex - 1. 	"adjust for zero-origin indexing"
	interpreterProxy failed ifFalse: [r := self cCode: 'asyncFileReadResult(f, bufferPtr, count)'].
	^ r asOop: SmallInteger