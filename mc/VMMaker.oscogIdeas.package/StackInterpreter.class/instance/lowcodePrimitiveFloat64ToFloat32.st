inline primitive generated code
lowcodePrimitiveFloat64ToFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| floatValue singleFloatResult |
	<var: #floatValue type: #'double' >
	<var: #singleFloatResult type: #'float' >
	floatValue := self internalPopStackFloat64.

	singleFloatResult := self cCoerce: floatValue to: 'float'.

	self internalPushFloat32: singleFloatResult.

