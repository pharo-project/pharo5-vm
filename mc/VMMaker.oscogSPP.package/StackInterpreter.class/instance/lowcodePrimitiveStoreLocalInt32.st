inline primitive generated code
lowcodePrimitiveStoreLocalInt32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value baseOffset |
	<var: #value type: #'sqInt' >
	baseOffset := extA.
	value := self internalPopStackInt32.

	stackPages int32AtPointer: (self framePointerOfNativeLocal: baseOffset in: localFP) put: value.

	extA := 0.

