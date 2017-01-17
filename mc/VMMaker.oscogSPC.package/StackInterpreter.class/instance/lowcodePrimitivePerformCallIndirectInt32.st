inline primitive generated code
lowcodePrimitivePerformCallIndirectInt32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result function |
	<var: #result type: #'sqInt' >
	<var: #function type: #'char*' >
	function := self internalPopStackPointer.

	result := self lowcodeCalloutInt32Result: function.

	self internalPushInt32: result.

