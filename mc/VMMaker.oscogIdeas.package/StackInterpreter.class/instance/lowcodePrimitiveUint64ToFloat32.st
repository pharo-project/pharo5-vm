inline primitive generated code
lowcodePrimitiveUint64ToFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'sqLong' >
	<var: #result type: #'float' >
	value := self internalPopStackInt64.

	result := self cCoerce: (self cCoerce: value to: 'uint64_t') to: 'float'.

	self internalPushFloat32: result.

