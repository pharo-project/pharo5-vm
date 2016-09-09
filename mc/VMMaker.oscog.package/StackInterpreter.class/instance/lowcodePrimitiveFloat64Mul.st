inline primitive generated code
lowcodePrimitiveFloat64Mul
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| second result first |
	<var: #second type: #'double' >
	<var: #result type: #'double' >
	<var: #first type: #'double' >
	second := self internalPopStackFloat64.
	first := self internalPopStackFloat64.

	result := first * second.

	self internalPushFloat64: result.

