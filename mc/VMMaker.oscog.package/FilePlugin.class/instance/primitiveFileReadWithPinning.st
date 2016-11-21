file primitives
primitiveFileReadWithPinning
	"This version of primitiveFileRead is for garbage collectors that support pinning."
	| count startIndex array file slotSize elementSize bytesRead |
	<inline: true>
	<var: 'file' type: #'SQFile *'>
	<var: 'count' type: #'size_t'>
	<var: 'startIndex' type: #'size_t'>
	<var: 'slotSize' type: #'size_t'>
	<var: 'elementSize' type: #'size_t'>
	count		:= interpreterProxy positiveMachineIntegerValueOf: (interpreterProxy stackValue: 0).
	startIndex	:= interpreterProxy positiveMachineIntegerValueOf: (interpreterProxy stackValue: 1).
 	array		:= interpreterProxy stackValue: 2.
	file			:= self fileValueOf: (interpreterProxy stackValue: 3).

	(interpreterProxy failed
	"buffer can be any indexable words or bytes object except CompiledMethod"
	 or: [(interpreterProxy isWordsOrBytes: array) not]) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].

	slotSize := interpreterProxy slotSizeOf: array.
	(startIndex >= 1 and: [startIndex + count - 1 <= slotSize]) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadIndex].

	"Note: adjust startIndex for zero-origin byte indexing"
	elementSize := slotSize = 0
						ifTrue: [1]
						ifFalse: [(interpreterProxy byteSizeOf: array) // slotSize].
	bytesRead := self
					sqFile: file
					Read: count * elementSize
					Into: (interpreterProxy cCoerce: (interpreterProxy firstIndexableField: array) to: #'char *')
					At: startIndex - 1 * elementSize.
	interpreterProxy failed ifFalse:
		[interpreterProxy
			pop: 5 "pop rcvr, file, array, startIndex, count"
			thenPush:(interpreterProxy integerObjectOf: bytesRead // elementSize)  "push # of elements read"]