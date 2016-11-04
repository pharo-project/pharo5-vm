inline primitive generated code
lowcodePrimitiveSignExtend64From16
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'sqLong' >
	<var: #result type: #'sqLong' >
	value := self internalPopStackInt64.

	result := self cCoerce: value to: 'int16_t'.

	self internalPushInt64: result.

