inline primitive generated code
lowcodePrimitiveStoreLocalFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value baseOffset |
	<var: #value type: #'float' >
	baseOffset := extA.
	value := self internalPopStackFloat32.

	stackPages singleFloatAtPointer: (self framePointerOfNativeLocal: baseOffset in: localFP) put: value.

	extA := 0.

