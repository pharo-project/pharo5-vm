inline primitive generated code
lowcodePrimitivePerformCallStructure
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| resultPointer result function structureSize |
	<var: #resultPointer type: #'char*' >
	<var: #result type: #'char*' >
	function := extA.
	structureSize := extB.
	result := self internalPopStackPointer.

	self internalPushShadowCallStackPointer: result.
	resultPointer := self lowcodeCalloutPointerResult: (self cCoerce: function to: #'char*').

	self internalPushPointer: resultPointer.
	extA := 0.
	extB := 0.

