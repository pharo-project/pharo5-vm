inline primitive generated code
lowcodePrimitiveFloat32Add
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| second result first |
	<var: #second type: #'float' >
	<var: #result type: #'float' >
	<var: #first type: #'float' >
	second := self internalPopStackFloat32.
	first := self internalPopStackFloat32.

	result := first + second.

	self internalPushFloat32: result.

