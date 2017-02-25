primitives
primitiveSocket: socket getOptions: optionName

	| s optionNameStart optionNameSize returnedValue errorCode results |
	<var: #s type: #SocketPtr>
	<var: #optionNameStart type: #'char *'>
	self primitive: 'primitiveSocketGetOptions'
		parameters: #(Oop Oop).

	s := self socketValueOf: socket.
	interpreterProxy success: (interpreterProxy isBytes: optionName).
	optionNameStart := self cCoerce: (interpreterProxy firstIndexableField: optionName) to: #'char *'.
	optionNameSize := interpreterProxy slotSizeOf: optionName.

	interpreterProxy failed ifTrue: [^nil].
	returnedValue := 0.

	errorCode := self sqSocketGetOptions: s 
					optionNameStart: optionNameStart 
					optionNameSize: optionNameSize
					returnedValue: (self addressOf: returnedValue).

	results := interpreterProxy instantiateClass: interpreterProxy classArray indexableSize: 2.
	interpreterProxy storePointer: 0 ofObject: results withValue: errorCode asSmallIntegerObj.
	interpreterProxy storePointer: 1 ofObject: results withValue: returnedValue asSmallIntegerObj.
	^ results