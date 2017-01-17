inline primitive generated code
lowcodePrimitiveFloat32ToUInt32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'float' >
	<var: #result type: #'sqInt' >
	value := self internalPopStackFloat32.

	result := self cCoerce: value to: 'uint32_t'.

	self internalPushInt32: result.

