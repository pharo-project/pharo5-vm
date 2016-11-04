inline primitive generated code
lowcodePrimitivePushPhysicalInt32
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| registerID value |
	<var: #value type: #'sqInt' >
	registerID := extA.

	value := self lowcodeCalloutState: lowcodeCalloutState int32Register: registerID.

	self internalPushInt32: value.
	extA := 0.

