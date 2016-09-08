inline primitive generated code
lowcodePrimitivePushConstantUInt32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result constant |
	<var: #result type: #'sqInt' >
	constant := extA.

	result := constant.

	self internalPushInt32: result.
	extA := 0.

