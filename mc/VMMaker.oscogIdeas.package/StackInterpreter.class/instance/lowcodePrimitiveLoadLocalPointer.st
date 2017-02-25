inline primitive generated code
lowcodePrimitiveLoadLocalPointer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointerResult baseOffset |
	<var: #pointerResult type: #'char*' >
	baseOffset := extA.

	pointerResult := stackPages pointerAtPointer: (self framePointerOfNativeLocal: baseOffset in: localFP).

	self internalPushPointer: pointerResult.
	extA := 0.

