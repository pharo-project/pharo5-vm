inline primitive generated code
lowcodePrimitiveInt32ToFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'sqInt' >
	<var: #result type: #'float' >
	value := self internalPopStackInt32.

	result := self cCoerce: value to: 'float'.

	self internalPushFloat32: result.

