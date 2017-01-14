inline primitive generated code
lowcodePrimitivePerformCallIndirectPointer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result function |
	<var: #result type: #'char*' >
	<var: #function type: #'char*' >
	function := self internalPopStackPointer.

	result := self lowcodeCalloutPointerResult: function.

	self internalPushPointer: result.

