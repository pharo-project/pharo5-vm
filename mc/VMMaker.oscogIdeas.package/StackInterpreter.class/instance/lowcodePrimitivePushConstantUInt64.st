inline primitive generated code
lowcodePrimitivePushConstantUInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result constant |
	<var: #result type: #'sqLong' >
	constant := extA.

	result := constant.

	self internalPushInt64: result.
	extA := 0.

