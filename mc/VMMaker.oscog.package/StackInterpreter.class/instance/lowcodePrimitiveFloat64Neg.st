inline primitive generated code
lowcodePrimitiveFloat64Neg
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'double' >
	<var: #result type: #'double' >
	value := self internalPopStackFloat64.

	result := value negated.

	self internalPushFloat64: result.

