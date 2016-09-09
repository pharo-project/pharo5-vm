inline primitive generated code
lowcodePrimitivePerformCallIndirectInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| result function |
	<var: #result type: #'sqLong' >
	<var: #function type: #'char*' >
	function := self internalPopStackPointer.

	result := self lowcodeCalloutInt64Result: function.

	self internalPushInt64: result.

