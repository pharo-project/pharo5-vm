callout support
dispatchFunctionPointer: aFunctionPointer with: int1 with: int2 with: int3 with: int4
	"In C aFunctionPointer is void (*aFunctionPointer)(int, int, int, int)"
	<cmacro: '(aFunctionPointer, int1, int2, int3, int4) (aFunctionPointer)(int1, int2, int3, int4)'>
	^self 
		perform: aFunctionPointer
		with: int1
		with: int2
		with: int3
		with: int4