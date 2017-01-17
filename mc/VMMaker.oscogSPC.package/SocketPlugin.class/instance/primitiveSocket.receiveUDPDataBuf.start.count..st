primitives
primitiveSocket: socket receiveUDPDataBuf: array start: startIndex count: count 
	| s elementSize arrayBase bufStart bytesReceived results address port moreFlag |
	<var: #s type: #SocketPtr>
	<var: #arrayBase type: #'char *'>
	<var: #bufStart type: #'char *'>
	self primitive: 'primitiveSocketReceiveUDPDataBufCount'
		parameters: #(Oop Oop SmallInteger SmallInteger).
	s := self socketValueOf: socket.

	"buffer can be any indexable words or bytes object"
	interpreterProxy success: (interpreterProxy isWordsOrBytes: array).
	(interpreterProxy isWords: array)
		ifTrue: [elementSize := 4]
		ifFalse: [elementSize := 1].
	interpreterProxy success: (startIndex >= 1
			and: [count >= 0 and: [startIndex + count - 1 <= (interpreterProxy slotSizeOf: array)]]).
	interpreterProxy failed
		ifFalse: ["Note: adjust bufStart for zero-origin indexing"
			arrayBase		:= self cCoerce: (interpreterProxy firstIndexableField: array) to: #'char *'.
			bufStart		:= arrayBase + (startIndex - 1 * elementSize).
			address		:= 0.
			port			:= 0.
			moreFlag		:= 0.
			bytesReceived := self sqSocket: s
									ReceiveUDPDataBuf: bufStart
									Count: count * elementSize
									address: (self addressOf: address)
									port: (self addressOf: port)
									moreFlag: (self addressOf: moreFlag).

			"allocate storage for results, remapping newly allocated
			 oops in case GC happens during allocation"
			interpreterProxy pushRemappableOop: (self intToNetAddress: address).
			results := interpreterProxy instantiateClass: interpreterProxy classArray indexableSize: 4.
			interpreterProxy storePointer: 0 ofObject: results withValue: (bytesReceived // elementSize) asSmallIntegerObj.
			interpreterProxy storePointer: 1 ofObject: results withValue: interpreterProxy popRemappableOop.
			interpreterProxy storePointer: 2 ofObject: results withValue: port asSmallIntegerObj.
			interpreterProxy storePointer: 3 ofObject: results withValue: (moreFlag
																			ifTrue: [interpreterProxy trueObject]
																			ifFalse: [interpreterProxy falseObject]).
			].
	^ results