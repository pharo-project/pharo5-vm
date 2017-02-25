inline primitive generated code
lowcodePrimitivePushZero32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result |
	<var: #result type: #'sqInt' >

	result := 0.

	self internalPushInt32: result.

