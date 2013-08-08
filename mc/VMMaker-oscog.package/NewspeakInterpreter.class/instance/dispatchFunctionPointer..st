message sending
dispatchFunctionPointer: aFunctionPointer
	"In C aFunctionPointer is void (*aFunctionPointer)()"
	<cmacro: '(aFunctionPointer) (aFunctionPointer)()'>
	(aFunctionPointer isInteger
	 and: [aFunctionPointer >= 1000]) ifTrue:
		[^self callExternalPrimitive: aFunctionPointer].
	"In Smalltalk aFunctionPointer is a message selector symbol"
	^self perform: aFunctionPointer