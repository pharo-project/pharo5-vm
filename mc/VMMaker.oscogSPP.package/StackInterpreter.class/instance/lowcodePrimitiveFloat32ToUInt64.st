inline primitive generated code
lowcodePrimitiveFloat32ToUInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'float' >
	<var: #result type: #'sqLong' >
	value := self internalPopStackFloat32.

	result := self cCoerce: value to: 'uint64_t'.

	self internalPushInt64: result.

