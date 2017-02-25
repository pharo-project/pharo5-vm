inline primitive generated code
lowcodePrimitiveBeginCall
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| alignment |
	alignment := extA.

	"Store the shadow stack pointer"
	self shadowCallStackPointerIn: localFP put: shadowCallStackPointer + 1.
	"Allocate the callout state"
	self allocateLowcodeCalloutState.

	extA := 0.

