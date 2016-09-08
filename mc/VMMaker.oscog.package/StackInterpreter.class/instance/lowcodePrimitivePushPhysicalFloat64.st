inline primitive generated code
lowcodePrimitivePushPhysicalFloat64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| registerID value |
	<var: #value type: #'double' >
	registerID := extA.

	value := self lowcodeCalloutState: lowcodeCalloutState float64Register: registerID.

	self internalPushFloat64: value.
	extA := 0.

