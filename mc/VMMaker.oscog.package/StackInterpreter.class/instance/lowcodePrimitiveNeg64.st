inline primitive generated code
lowcodePrimitiveNeg64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'sqLong' >
	<var: #result type: #'sqLong' >
	value := self internalPopStackInt64.

	result := value negated.

	self internalPushInt64: result.

