inline primitive generated code
lowcodePrimitivePerformCallIndirectFloat64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result function |
	<var: #result type: #'double' >
	<var: #function type: #'char*' >
	function := self internalPopStackPointer.

	result := self lowcodeCalloutFloat64Result: function.

	self internalPushFloat64: result.

