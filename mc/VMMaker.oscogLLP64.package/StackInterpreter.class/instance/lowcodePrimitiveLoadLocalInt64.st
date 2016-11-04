inline primitive generated code
lowcodePrimitiveLoadLocalInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value baseOffset |
	<var: #value type: #'sqLong' >
	baseOffset := extA.

	value := stackPages int64AtPointer: (self framePointerOfNativeLocal: baseOffset in: localFP).

	self internalPushInt64: value.
	extA := 0.

