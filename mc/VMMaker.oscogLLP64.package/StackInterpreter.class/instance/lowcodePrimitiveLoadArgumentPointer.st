inline primitive generated code
lowcodePrimitiveLoadArgumentPointer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointerResult baseOffset |
	<var: #pointerResult type: #'char*' >
	baseOffset := extA.

	pointerResult := stackPages pointerAtPointer: (self framePointerOfNativeArgument: baseOffset in: localFP).

	self internalPushPointer: pointerResult.
	extA := 0.

