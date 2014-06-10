message sending
dispatchFunctionPointer: aFunctionPointer
	"In C aFunctionPointer is void (*aFunctionPointer)()"
	<cmacro: '(aFunctionPointer) (aFunctionPointer)()'>
	| result |
	(aFunctionPointer isInteger
	 and: [aFunctionPointer >= 1000]) ifTrue:
		[result := self callExternalPrimitive: aFunctionPointer.
		 objectMemory checkForLastObjectOverwrite.
		 ^result].
	"In Smalltalk aFunctionPointer is a message selector symbol"
	result := self perform: aFunctionPointer.
	 objectMemory checkForLastObjectOverwrite.
	 ^result