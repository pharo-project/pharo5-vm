inline primitive generated code
lowcodePrimitivePerformCallInt32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result function |
	<var: #result type: #'sqInt' >
	function := extA.

	result := self lowcodeCalloutInt32Result: (self cCoerce: function to: #'char*').

	self internalPushInt32: result.
	extA := 0.

