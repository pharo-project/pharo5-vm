internal interpreter access
internalPushShadowCallStackSpace: spaceSize
	<option: #LowcodeVM>
	"In the StackInterpreter stacks grow down."
	shadowCallStackPointer := shadowCallStackPointer - spaceSize.