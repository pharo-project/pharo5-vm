inline primitive generated code
lowcodePrimitiveZeroExtend64From8
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'sqLong' >
	<var: #result type: #'sqLong' >
	value := self internalPopStackInt64.

	result := self cCoerce: value to: 'uint8_t'.

	self internalPushInt64: result.

