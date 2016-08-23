message sending
dispatchFunctionPointer: aFunctionPointer
	"In C aFunctionPointer is void (*aFunctionPointer)()"
	<cmacro: '(aFunctionPointer) (aFunctionPointer)()'>
	"In Smalltalk aFunctionPointer is a message selector symbol, except for
	 external primitives which are funkily encoded as integers >= 1000."
	(aFunctionPointer isInteger
	 and: [aFunctionPointer >= 1000])
		ifTrue: [self callExternalPrimitive: aFunctionPointer]
		ifFalse: [self perform: aFunctionPointer]