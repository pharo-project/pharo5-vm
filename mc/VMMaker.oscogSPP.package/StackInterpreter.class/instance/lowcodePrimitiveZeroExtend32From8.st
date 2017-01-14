inline primitive generated code
lowcodePrimitiveZeroExtend32From8
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'sqInt' >
	<var: #result type: #'sqInt' >
	value := self internalPopStackInt32.

	result := self cCoerce: value to: 'uint8_t'.

	self internalPushInt32: result.

