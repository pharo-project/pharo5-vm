file primitives
primitiveFileWrite
	| count startIndex array file elementSize bytesWritten |
	<var: 'file' type: 'SQFile *'>
	<var: 'count' type: 'size_t'>
	<var: 'startIndex' type: 'size_t'>
	<var: 'elementSize' type: 'size_t'>
	<export: true>
	count := interpreterProxy positive32BitValueOf: (interpreterProxy stackValue: 0).
	startIndex := interpreterProxy positive32BitValueOf: (interpreterProxy stackValue: 1).
	array := interpreterProxy stackValue: 2.
	file := self fileValueOf: (interpreterProxy stackValue: 3).

	 (interpreterProxy failed
	 "buffer can be any indexable words or bytes object except CompiledMethod"
	 or: [(interpreterProxy isWordsOrBytes: array) not]) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].

	 elementSize := (interpreterProxy isWords: array) ifTrue: [4] ifFalse: [1].
	 (startIndex >= 1
	  and: [(startIndex + count - 1) <= (interpreterProxy slotSizeOf: array)]) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadIndex].

	"Note: adjust startIndex for zero-origin indexing"
	bytesWritten := self
						sqFile: file
						Write: count * elementSize
						From: (interpreterProxy cCoerce: (interpreterProxy firstIndexableField: array) to: #'char *')
						At: startIndex - 1 * elementSize.
	interpreterProxy failed ifFalse:
		[interpreterProxy pop: 5 thenPush: (interpreterProxy integerObjectOf: bytesWritten // elementSize)]