inline primitive generated code
lowcodePrimitiveMoveInt32ToPhysical
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| registerID value |
	<var: #value type: #'sqInt' >
	registerID := extA.
	value := self internalPopStackInt32.

	self lowcodeCalloutState: lowcodeCalloutState int32Register: registerID value: value.

	extA := 0.

