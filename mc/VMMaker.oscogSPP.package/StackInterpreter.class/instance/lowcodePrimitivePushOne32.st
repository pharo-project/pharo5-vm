inline primitive generated code
lowcodePrimitivePushOne32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result |
	<var: #result type: #'sqInt' >

	result := 1.

	self internalPushInt32: result.

