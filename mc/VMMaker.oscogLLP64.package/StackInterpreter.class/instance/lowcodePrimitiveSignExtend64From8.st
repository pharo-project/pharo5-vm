inline primitive generated code
lowcodePrimitiveSignExtend64From8
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'sqLong' >
	<var: #result type: #'sqLong' >
	value := self internalPopStackInt64.

	result := self cCoerce: value to: 'signed char'.

	self internalPushInt64: result.

