internal interpreter access
internalPopStackInt32
	<option: #LowcodeVM>
	"In the StackInterpreter stacks grow down."
	| topInt32 |
	nativeSP := self nativeStackPointerIn: localFP.
	topInt32 := stackPages int32AtPointer: nativeSP - 1.
	nativeSP := self nativeStackPointerIn: localFP put: nativeSP + objectMemory bytesPerOop.
	^topInt32