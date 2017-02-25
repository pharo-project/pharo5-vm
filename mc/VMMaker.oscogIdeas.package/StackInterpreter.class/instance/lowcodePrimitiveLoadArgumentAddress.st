inline primitive generated code
lowcodePrimitiveLoadArgumentAddress
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer baseOffset |
	<var: #pointer type: #'char*' >
	baseOffset := extA.

	pointer := self framePointerOfNativeArgument: baseOffset in: localFP.

	self internalPushPointer: pointer.
	extA := 0.

