inline primitive generated code
lowcodePrimitiveStoreLocalFloat64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value baseOffset |
	<var: #value type: #'double' >
	baseOffset := extA.
	value := self internalPopStackFloat64.

	stackPages floatAtPointer: (self framePointerOfNativeLocal: baseOffset in: localFP) put: value.

	extA := 0.

