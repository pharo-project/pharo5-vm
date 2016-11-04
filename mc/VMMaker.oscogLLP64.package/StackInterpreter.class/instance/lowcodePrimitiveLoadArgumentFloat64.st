inline primitive generated code
lowcodePrimitiveLoadArgumentFloat64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| doubleValue baseOffset |
	<var: #doubleValue type: #'double' >
	baseOffset := extA.

	doubleValue := stackPages floatAtPointer: (self framePointerOfNativeArgument: baseOffset in: localFP).

	self internalPushFloat64: doubleValue.
	extA := 0.

