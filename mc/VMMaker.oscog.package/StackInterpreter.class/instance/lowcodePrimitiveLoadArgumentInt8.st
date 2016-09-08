inline primitive generated code
lowcodePrimitiveLoadArgumentInt8
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value baseOffset |
	<var: #value type: #'sqInt' >
	baseOffset := extA.

	value := stackPages int8AtPointer: (self framePointerOfNativeArgument: baseOffset in: localFP).

	self internalPushInt32: value.
	extA := 0.

