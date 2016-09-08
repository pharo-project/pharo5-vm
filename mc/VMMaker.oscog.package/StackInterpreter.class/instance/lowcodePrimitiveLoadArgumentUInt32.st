inline primitive generated code
lowcodePrimitiveLoadArgumentUInt32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value baseOffset |
	<var: #value type: #'sqInt' >
	baseOffset := extA.

	value := stackPages uint32AtPointer: (self framePointerOfNativeArgument: baseOffset in: localFP).

	self internalPushInt32: value.
	extA := 0.

