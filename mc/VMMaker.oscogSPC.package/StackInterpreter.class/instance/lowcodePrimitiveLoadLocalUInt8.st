inline primitive generated code
lowcodePrimitiveLoadLocalUInt8
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value baseOffset |
	<var: #value type: #'sqInt' >
	baseOffset := extA.

	value := stackPages uint8AtPointer: (self framePointerOfNativeLocal: baseOffset in: localFP).

	self internalPushInt32: value.
	extA := 0.

