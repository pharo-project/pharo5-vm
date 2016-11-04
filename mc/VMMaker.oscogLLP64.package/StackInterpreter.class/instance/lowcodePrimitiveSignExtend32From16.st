inline primitive generated code
lowcodePrimitiveSignExtend32From16
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'sqInt' >
	<var: #result type: #'sqInt' >
	value := self internalPopStackInt32.

	result := self cCoerce: value to: 'signed short'.

	self internalPushInt32: result.

