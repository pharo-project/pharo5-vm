inline primitive generated code
lowcodePrimitiveLoadArgumentFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| floatValue baseOffset |
	<var: #floatValue type: #'float' >
	baseOffset := extA.

	floatValue := stackPages singleFloatAtPointer: (self framePointerOfNativeArgument: baseOffset in: localFP).

	self internalPushFloat32: floatValue.
	extA := 0.

