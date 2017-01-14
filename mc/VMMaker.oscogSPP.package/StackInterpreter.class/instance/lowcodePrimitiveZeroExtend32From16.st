inline primitive generated code
lowcodePrimitiveZeroExtend32From16
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'sqInt' >
	<var: #result type: #'sqInt' >
	value := self internalPopStackInt32.

	result := self cCoerce: value to: 'uint16_t'.

	self internalPushInt32: result.

