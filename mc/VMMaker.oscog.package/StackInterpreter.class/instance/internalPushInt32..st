internal interpreter access
internalPushInt32: int32Value
	<option: #LowcodeVM>
	"In the StackInterpreter stacks grow down."
	nativeSP := (self nativeStackPointerIn: localFP) - objectMemory bytesPerOop.
	self nativeStackPointerIn: localFP put: nativeSP.

	"In the StackInterpreter stacks grow down."
	stackPages int32AtPointer: (nativeSP - 1) put: int32Value
