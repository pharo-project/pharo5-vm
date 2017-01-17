inline primitive generated code
lowcodePrimitiveMoveFloat64ToPhysical
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| registerID value |
	<var: #value type: #'double' >
	registerID := extA.
	value := self internalPopStackFloat64.

	self lowcodeCalloutState: lowcodeCalloutState float64Register: registerID value: value.

	extA := 0.

