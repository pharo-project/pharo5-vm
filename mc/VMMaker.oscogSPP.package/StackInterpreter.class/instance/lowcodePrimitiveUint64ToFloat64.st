inline primitive generated code
lowcodePrimitiveUint64ToFloat64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'sqLong' >
	<var: #result type: #'double' >
	value := self internalPopStackInt64.

	result := self cCoerce: (self cCoerce: value to: 'uint64_t') to: 'double'.

	self internalPushFloat64: result.

