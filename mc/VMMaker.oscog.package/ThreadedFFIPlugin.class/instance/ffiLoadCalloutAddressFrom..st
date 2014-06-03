symbol loading
ffiLoadCalloutAddressFrom: oop
	"Load the function address for a call out to an external function"
	| module moduleHandle functionName functionLength address |
	<inline: false>
	"First find and load the module"
	module := interpreterProxy fetchPointer: externalFunctionInstSize + 1 ofObject: oop.
	moduleHandle := self ffiLoadCalloutModule: module.
	interpreterProxy failed ifTrue:
		[^0]. "failed"
	"fetch the function name"
	functionName := interpreterProxy fetchPointer: externalFunctionInstSize ofObject: oop.
	(interpreterProxy isBytes: functionName) ifFalse:
		[^self ffiFail: FFIErrorBadExternalFunction].
	functionLength := interpreterProxy byteSizeOf: functionName.
	address := interpreterProxy
					ioLoadSymbol: (self cCoerce: (interpreterProxy firstIndexableField: functionName) to: #int)
					OfLength: functionLength 
					FromModule: moduleHandle.
	(interpreterProxy failed or: [address = 0]) ifTrue:
		[^self ffiFail: FFIErrorAddressNotFound].
	^address