internal interpreter access
internalPushShadowCallStackFloat64: floatValue
	<option: #LowcodeVM>
	<var: #floatValue type: #double >
	"In the StackInterpreter stacks grow down."
	shadowCallStackPointer := shadowCallStackPointer - 8.

	"In the StackInterpreter stacks grow down."
	stackPages singleFloatAtPointer: shadowCallStackPointer put: floatValue