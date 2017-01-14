inline primitive generated code
lowcodePrimitivePerformCallIndirectVoid
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| function |
	<var: #function type: #'char*' >
	function := self internalPopStackPointer.

	self lowcodeCalloutInt32Result: function.


