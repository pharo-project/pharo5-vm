primitives
primitiveSocket: socket setOptions: optionName value: optionValue
	"THIS BADLY NEEDS TO BE REWRITTEN TO TAKE Booleans AND Integers AS WELL AS (OR INSTEAD OF) Strings.
	 It is only used with booleans and integers and parsing these back out of strings in
	 sqSocketSetOptions:optionNameStart:optionNameSize:optionValueStart:optionValueSize:returnedValue:
	 is STUPID."
	| s optionNameStart optionNameSize optionValueStart optionValueSize returnedValue errorCode results |
	<var: #s type: #SocketPtr>
	<var: #optionNameStart type: #'char *'>
	<var: #optionValueStart type: #'char *'>
	self primitive: 'primitiveSocketSetOptions'
		parameters: #(Oop Oop Oop).

	s := self socketValueOf: socket.
	interpreterProxy success: (interpreterProxy isBytes: optionName).
	optionNameStart := self cCoerce: (interpreterProxy firstIndexableField: optionName) to: #'char *'.
	optionNameSize := interpreterProxy slotSizeOf: optionName.
	interpreterProxy success: (interpreterProxy isBytes: optionValue).
	optionValueStart:= self cCoerce: (interpreterProxy firstIndexableField: optionValue) to: #'char *'.
	optionValueSize := interpreterProxy slotSizeOf: optionValue.

	interpreterProxy failed ifTrue: [^nil].
	returnedValue := 0.

	errorCode := self sqSocketSetOptions: s 
					optionNameStart: optionNameStart 
					optionNameSize: optionNameSize
					optionValueStart: optionValueStart
					optionValueSize: optionValueSize
					returnedValue: (self addressOf: returnedValue).

	results := interpreterProxy instantiateClass: interpreterProxy classArray indexableSize: 2.
	interpreterProxy storePointer: 0 ofObject: results withValue: errorCode asSmallIntegerObj.
	interpreterProxy storePointer: 1 ofObject: results withValue: returnedValue asSmallIntegerObj.
	^ results