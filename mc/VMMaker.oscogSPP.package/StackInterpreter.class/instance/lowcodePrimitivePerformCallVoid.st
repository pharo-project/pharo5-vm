inline primitive generated code
lowcodePrimitivePerformCallVoid
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| function |
	function := extA.

	self lowcodeCalloutInt32Result: (self cCoerce: function to: #'char*').

	extA := 0.

