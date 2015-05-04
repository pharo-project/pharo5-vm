other
primitiveFailFor: reasonCode
	"Set specific primitive failure.
	N.B. primitiveFailFor: PrimNoErr is expected to clear the primFailCode.
	Primitive 255 is called to indicate that we are currently simulating a primitive that should fail and the VM should handle that case appropriately (if supported by the VM)."
	<primitive: 255>
	^ primFailCode := reasonCode