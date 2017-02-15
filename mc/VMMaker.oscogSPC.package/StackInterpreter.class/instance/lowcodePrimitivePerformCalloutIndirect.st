inline primitive generated code
lowcodePrimitivePerformCalloutIndirect
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| function |
	<var: #function type: #'char*' >
	function := self internalPopStackPointer.

	self lowcodeDoCallout: function.


