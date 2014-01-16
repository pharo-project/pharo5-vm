I/O primitives deprecated
primitiveScreenDepth
	"Return a SmallInteger indicating the current depth of the OS screen. Negative values are used to imply LSB type pixel format an there is some support in the VM for handling either MSB or LSB"
 	<export: true>
	self primitiveFailFor: PrimErrUnsupported.