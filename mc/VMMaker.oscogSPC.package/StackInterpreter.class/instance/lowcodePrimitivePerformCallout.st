inline primitive generated code
lowcodePrimitivePerformCallout
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| function |
	function := extA.

	self lowcodeDoCallout: (self cCoerce: function to: #'char*').

	extA := 0.

