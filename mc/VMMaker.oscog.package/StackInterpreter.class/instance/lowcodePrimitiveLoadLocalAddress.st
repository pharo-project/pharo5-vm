inline primitive generated code
lowcodePrimitiveLoadLocalAddress
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| pointer baseOffset |
	<var: #pointer type: #'char*' >
	baseOffset := extA.

	pointer := self framePointerOfNativeLocal: baseOffset in: localFP.

	self internalPushPointer: pointer.
	extA := 0.

