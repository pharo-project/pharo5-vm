inline primitive generated code
lowcodePrimitiveLoadArgumentInt32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value baseOffset |
	<var: #value type: #'sqInt' >
	baseOffset := extA.

	value := stackPages int32AtPointer: (self framePointerOfNativeArgument: baseOffset in: localFP).

	self internalPushInt32: value.
	extA := 0.

