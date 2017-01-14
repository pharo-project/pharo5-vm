inline primitive generated code
lowcodePrimitiveLoadArgumentInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value baseOffset |
	<var: #value type: #'sqLong' >
	baseOffset := extA.

	value := stackPages int64AtPointer: (self framePointerOfNativeArgument: baseOffset in: localFP).

	self internalPushInt64: value.
	extA := 0.

