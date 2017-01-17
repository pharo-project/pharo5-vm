inline primitive generated code
lowcodePrimitivePerformCallFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result function |
	<var: #result type: #'float' >
	function := extA.

	result := self lowcodeCalloutFloat32Result: (self cCoerce: function to: #'char*').

	self internalPushFloat32: result.
	extA := 0.

