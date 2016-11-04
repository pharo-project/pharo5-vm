inline primitive generated code
lowcodePrimitiveSignExtend32From8
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'sqInt' >
	<var: #result type: #'sqInt' >
	value := self internalPopStackInt32.

	result := self cCoerce: value to: 'signed char'.

	self internalPushInt32: result.

