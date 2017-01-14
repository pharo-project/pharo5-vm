inline primitive generated code
lowcodePrimitiveLoadLocalUInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value baseOffset |
	<var: #value type: #'sqLong' >
	baseOffset := extA.

	value := stackPages uint64AtPointer: (self framePointerOfNativeLocal: baseOffset in: localFP).

	self internalPushInt64: value.
	extA := 0.

