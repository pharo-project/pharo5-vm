inline primitive generated code
lowcodePrimitivePerformCallFloat64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result function |
	<var: #result type: #'double' >
	function := extA.

	result := self lowcodeCalloutFloat64Result: (self cCoerce: function to: #'char*').

	self internalPushFloat64: result.
	extA := 0.

