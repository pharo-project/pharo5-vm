primitives
primitiveSocket: socket sendData: array start: startIndex count: count 
	| s byteSize arrayBase bufStart bytesSent |
	<var: #s type: 'SocketPtr'>
	<var: #arrayBase type: 'char *'>
	<var: #bufStart type: 'char *'>
	self primitive: 'primitiveSocketSendDataBufCount'
		parameters: #(Oop Oop SmallInteger SmallInteger ).
	s := self socketValueOf: socket.

	"buffer can be any indexable words or bytes object except CompiledMethod "
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
			bytesSent := self
						sqSocket: s
						SendDataBuf: bufStart
						Count: count * byteSize].
	^ (bytesSent // byteSize) asSmallIntegerObj