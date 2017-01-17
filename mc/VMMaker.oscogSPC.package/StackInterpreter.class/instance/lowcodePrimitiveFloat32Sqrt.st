inline primitive generated code
lowcodePrimitiveFloat32Sqrt
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| value result |
	<var: #value type: #'float' >
	<var: #result type: #'float' >
	value := self internalPopStackFloat32.

	result := self sqrt: value.

	self internalPushFloat32: result.

