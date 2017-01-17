inline primitive generated code
lowcodePrimitivePushPhysicalPointer
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| registerID pointerValue |
	<var: #pointerValue type: #'char*' >
	registerID := extA.

	pointerValue := self lowcodeCalloutState: lowcodeCalloutState pointerRegister: registerID.

	self internalPushPointer: pointerValue.
	extA := 0.

