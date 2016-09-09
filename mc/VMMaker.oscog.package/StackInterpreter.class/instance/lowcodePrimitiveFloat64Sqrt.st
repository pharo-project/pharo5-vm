inline primitive generated code
lowcodePrimitiveFloat64Sqrt
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'double' >
	<var: #result type: #'double' >
	value := self internalPopStackFloat64.

	result := self sqrt: value.

	self internalPushFloat64: result.

