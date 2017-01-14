inline primitive generated code
lowcodePrimitiveStoreLocalPointer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointerValue baseOffset |
	<var: #pointerValue type: #'char*' >
	baseOffset := extA.
	pointerValue := self internalPopStackPointer.

	stackPages pointerAtPointer: (self framePointerOfNativeLocal: baseOffset in: localFP) put: pointerValue.

	extA := 0.

