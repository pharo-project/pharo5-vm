callout support
dispatchFunctionPointer: aFunctionPointer with: int1 with: int2 with: int3 with: int4 with: int5 with: int6
	"In C aFunctionPointer is void (*aFunctionPointer)(int, int, int, int)"
	<cmacro: '(aFunctionPointer,a1,a2, a3, a4,a5,a6) (aFunctionPointer)(a1,a2, a3, a4,a5,a6)'>
	^self 
		perform: aFunctionPointer
		with: int1
		with: int2
		with: int3
		with: int4
		with: int5
		with: int6