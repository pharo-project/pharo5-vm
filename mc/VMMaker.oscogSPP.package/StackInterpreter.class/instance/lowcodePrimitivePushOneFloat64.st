inline primitive generated code
lowcodePrimitivePushOneFloat64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result |
	<var: #result type: #'double' >

	result := 1.0.

	self internalPushFloat64: result.

