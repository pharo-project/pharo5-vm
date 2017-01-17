inline primitive generated code
lowcodePrimitiveLoadLocalFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| floatValue baseOffset |
	<var: #floatValue type: #'float' >
	baseOffset := extA.

	floatValue := stackPages singleFloatAtPointer: (self framePointerOfNativeLocal: baseOffset in: localFP).

	self internalPushFloat32: floatValue.
	extA := 0.

