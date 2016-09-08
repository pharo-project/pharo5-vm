inline primitive generated code
lowcodePrimitivePushPhysicalFloat32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| registerID value |
	<var: #value type: #'float' >
	registerID := extA.

	value := self lowcodeCalloutState: lowcodeCalloutState float32Register: registerID.

	self internalPushFloat32: value.
	extA := 0.

