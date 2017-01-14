inline primitive generated code
lowcodePrimitiveMovePointerToPhysical
	<option: #LowcodeVM>	"Lowcode instruction generator"
	| registerID pointerValue |
	<var: #pointerValue type: #'char*' >
	registerID := extA.
	pointerValue := self internalPopStackPointer.

	self lowcodeCalloutState: lowcodeCalloutState pointerRegister: registerID value: pointerValue.

	extA := 0.

