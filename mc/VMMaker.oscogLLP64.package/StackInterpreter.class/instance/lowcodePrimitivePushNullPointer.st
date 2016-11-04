inline primitive generated code
lowcodePrimitivePushNullPointer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result |
	<var: #result type: #'char*' >

	result := 0.

	self internalPushPointer: result.

