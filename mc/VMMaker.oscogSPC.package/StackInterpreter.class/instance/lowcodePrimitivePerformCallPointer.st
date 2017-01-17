inline primitive generated code
lowcodePrimitivePerformCallPointer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result function |
	<var: #result type: #'char*' >
	function := extA.

	result := self lowcodeCalloutPointerResult: (self cCoerce: function to: #'char*').

	self internalPushPointer: result.
	extA := 0.

