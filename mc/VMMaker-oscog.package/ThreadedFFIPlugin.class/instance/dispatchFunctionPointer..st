callout support
dispatchFunctionPointer: aFunctionPointer
	"In C aFunctionPointer is void (*aFunctionPointer)()"
	<cmacro: '(aFunctionPointer) (aFunctionPointer)()'>
	^self perform: aFunctionPointer