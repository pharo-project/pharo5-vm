inline primitive generated code
lowcodePrimitivePopMultipleNative
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| popSize |
	popSize := extA.

	self internalPopStackNativeSize: popSize.

	extA := 0.

