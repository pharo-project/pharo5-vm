inline primitive generated code
lowcodePrimitiveInt64ToFloat64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'sqLong' >
	<var: #result type: #'double' >
	value := self internalPopStackInt64.

	result := self cCoerce: value to: 'double'.

	self internalPushFloat64: result.

