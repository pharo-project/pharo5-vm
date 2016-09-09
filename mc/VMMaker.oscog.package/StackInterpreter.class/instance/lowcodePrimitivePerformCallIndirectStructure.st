inline primitive generated code
lowcodePrimitivePerformCallIndirectStructure
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| resultPointer result function structureSize |
	<var: #resultPointer type: #'char*' >
	<var: #result type: #'char*' >
	<var: #function type: #'char*' >
	structureSize := extA.
	result := self internalPopStackPointer.
	function := self internalPopStackPointer.

	resultPointer := self lowcodeCallout: function structureResult: result.

	self internalPushPointer: resultPointer.
	extA := 0.

