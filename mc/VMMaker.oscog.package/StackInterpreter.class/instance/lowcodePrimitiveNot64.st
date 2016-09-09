inline primitive generated code
lowcodePrimitiveNot64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'sqLong' >
	<var: #result type: #'sqLong' >
	value := self internalPopStackInt64.

	result := value bitXor: -1.

	self internalPushInt64: result.

