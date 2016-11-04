internal interpreter access
internalPushFloat32: singleFloatValue
	<option: #LowcodeVM>
	<var: #singleFloatValue type: #float >
	"In the StackInterpreter stacks grow down."
	nativeSP := (self nativeStackPointerIn: localFP) - 4.
	self nativeStackPointerIn: localFP put: nativeSP.

	"In the StackInterpreter stacks grow down."
	stackPages singleFloatAtPointer: (nativeSP - 1) put: singleFloatValue