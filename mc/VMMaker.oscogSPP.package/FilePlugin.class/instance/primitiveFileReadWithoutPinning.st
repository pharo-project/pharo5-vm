file primitives
primitiveFileReadWithoutPinning
	"This version of primitiveFileRead is for garbage collectors without support for pinning."
	| retryCount count startIndex array file elementSize bytesRead |
	<inline: true>
	<var: 'file' type: #'SQFile *'>
	<var: 'count' type: #'size_t'>
	<var: 'startIndex' type: #'size_t'>
	<var: 'elementSize' type: #'size_t'>
	retryCount	:= 0.
	count		:= interpreterProxy positive32BitValueOf: (interpreterProxy stackValue: 0).
	startIndex	:= interpreterProxy positive32BitValueOf: (interpreterProxy stackValue: 1).
 
	[array		:= interpreterProxy stackValue: 2.
	 file			:= self fileValueOf: (interpreterProxy stackValue: 3).

	 (interpreterProxy failed
	 "buffer can be any indexable words or bytes object except CompiledMethod"
	 or: [(interpreterProxy isWordsOrBytes: array) not]) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].

	 elementSize := (interpreterProxy isWords: array) ifTrue: [4] ifFalse: [1].
	 (startIndex >= 1
	  and: [(startIndex + count - 1) <= (interpreterProxy slotSizeOf: array)]) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadIndex].

	 "Note: adjust startIndex for zero-origin indexing"
	 bytesRead := self
					sqFile: file
					Read: count * elementSize
					Into: (interpreterProxy cCoerce: (interpreterProxy firstIndexableField: array) to: #'char *')
					At: (startIndex - 1) * elementSize.
	 interpreterProxy primitiveFailureCode = PrimErrObjectMayMove
	 and: [(retryCount := retryCount + 1) <= 2] "Two objects, the file and the array can move"] whileTrue:
		[interpreterProxy
			tenuringIncrementalGC;
			primitiveFailFor: PrimNoErr].
	interpreterProxy failed ifFalse:
		[interpreterProxy
			pop: 5 "pop rcvr, file, array, startIndex, count"
			thenPush:(interpreterProxy integerObjectOf: bytesRead // elementSize)  "push # of elements read"]