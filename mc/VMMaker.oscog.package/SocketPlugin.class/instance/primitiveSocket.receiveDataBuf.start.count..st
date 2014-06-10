primitives
primitiveSocket: socket receiveDataBuf: array start: startIndex count: count 
	| s byteSize arrayBase bufStart bytesReceived |
	<var: #s type: 'SocketPtr'>
	<var: #arrayBase type: 'char *'>
	<var: #bufStart type: 'char *'>
	self primitive: 'primitiveSocketReceiveDataBufCount'
		parameters: #(Oop Oop SmallInteger SmallInteger ).
	s := self socketValueOf: socket.

	"buffer can be any indexable words or bytes object"
	interpreterProxy success: (interpreterProxy isWordsOrBytes: array).
	(interpreterProxy isWords: array)
		ifTrue: [byteSize := 4]
		ifFalse: [byteSize := 1].
	interpreterProxy success: (startIndex >= 1
			and: [count >= 0 and: [startIndex + count - 1 <= (interpreterProxy slotSizeOf: array)]]).
	interpreterProxy failed
		ifFalse: ["Note: adjust bufStart for zero-origin indexing"
			arrayBase := self cCoerce: (interpreterProxy firstIndexableField: array) to: 'char *'.
			bufStart := arrayBase + (startIndex - 1 * byteSize).
			bytesReceived := self
						sqSocket: s
						ReceiveDataBuf: bufStart
						Count: count * byteSize].
	^ (bytesReceived // byteSize) asSmallIntegerObj