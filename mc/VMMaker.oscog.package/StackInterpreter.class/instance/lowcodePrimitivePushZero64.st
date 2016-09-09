inline primitive generated code
lowcodePrimitivePushZero64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result |
	<var: #result type: #'sqLong' >

	result := 0.

	self internalPushInt64: result.

