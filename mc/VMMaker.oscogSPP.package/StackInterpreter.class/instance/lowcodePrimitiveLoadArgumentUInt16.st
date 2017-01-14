inline primitive generated code
lowcodePrimitiveLoadArgumentUInt16
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value baseOffset |
	<var: #value type: #'sqInt' >
	baseOffset := extA.

	value := stackPages uint16AtPointer: (self framePointerOfNativeArgument: baseOffset in: localFP).

	self internalPushInt32: value.
	extA := 0.

