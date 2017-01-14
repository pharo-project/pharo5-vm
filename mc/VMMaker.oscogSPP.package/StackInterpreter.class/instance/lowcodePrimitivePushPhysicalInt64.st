inline primitive generated code
lowcodePrimitivePushPhysicalInt64
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| registerID value |
	<var: #value type: #'sqLong' >
	registerID := extA.

	value := self lowcodeCalloutState: lowcodeCalloutState int64Register: registerID.

	self internalPushInt64: value.
	extA := 0.

