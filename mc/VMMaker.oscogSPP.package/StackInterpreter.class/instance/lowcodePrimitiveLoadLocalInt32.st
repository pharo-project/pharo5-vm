inline primitive generated code
lowcodePrimitiveLoadLocalInt32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value baseOffset |
	<var: #value type: #'sqInt' >
	baseOffset := extA.

	value := stackPages int32AtPointer: (self framePointerOfNativeLocal: baseOffset in: localFP).

	self internalPushInt32: value.
	extA := 0.

