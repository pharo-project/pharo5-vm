inline primitive generated code
lowcodePrimitivePerformCallIndirectFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result function |
	<var: #result type: #'float' >
	<var: #function type: #'char*' >
	function := self internalPopStackPointer.

	result := self lowcodeCalloutFloat32Result: function.

	self internalPushFloat32: result.

