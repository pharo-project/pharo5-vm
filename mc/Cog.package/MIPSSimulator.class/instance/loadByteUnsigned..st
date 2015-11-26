instructions - memory
loadByteUnsigned: instruction
	| base address value |
	base := self unsignedRegister: instruction rs.
	address := base + instruction signedImmediate.
	value := self unsignedByte: address.
	self unsignedRegister: instruction rt put: value.