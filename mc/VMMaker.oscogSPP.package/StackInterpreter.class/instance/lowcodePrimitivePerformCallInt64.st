inline primitive generated code
lowcodePrimitivePerformCallInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result function |
	<var: #result type: #'sqLong' >
	function := extA.

	result := self lowcodeCalloutInt64Result: (self cCoerce: function to: #'char*').

	self internalPushInt64: result.
	extA := 0.

