inline primitive generated code
lowcodePrimitiveFloat32ToFloat64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| singleFloatValue doubleResult |
	<var: #singleFloatValue type: #'float' >
	<var: #doubleResult type: #'double' >
	singleFloatValue := self internalPopStackFloat32.

	doubleResult := self cCoerce: singleFloatValue to: 'double'.

	self internalPushFloat64: doubleResult.

