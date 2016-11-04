inline primitive generated code
lowcodePrimitiveLoadLocalUInt16
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value baseOffset |
	<var: #value type: #'sqInt' >
	baseOffset := extA.

	value := stackPages uint16AtPointer: (self framePointerOfNativeLocal: baseOffset in: localFP).

	self internalPushInt32: value.
	extA := 0.

