internal interpreter access
internalPushInt64: int64Value
	<option: #LowcodeVM>
	<arg: #int64Value type: #sqLong >
	"In the StackInterpreter stacks grow down."
	nativeSP := (self nativeStackPointerIn: localFP) - 8.
	self nativeStackPointerIn: localFP put: nativeSP.

	"In the StackInterpreter stacks grow down."
	stackPages long64AtPointer: (nativeSP - 1) put: int64Value
