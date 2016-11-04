internal interpreter access
internalPushShadowCallStackPointer: pointerValue
	<option: #LowcodeVM>
	<var: #pointerValue type: #'char*' >
	"In the StackInterpreter stacks grow down."
	shadowCallStackPointer := shadowCallStackPointer - BytesPerOop.

	"In the StackInterpreter stacks grow down."
	stackPages pointerAtPointer: shadowCallStackPointer put: pointerValue