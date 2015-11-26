instructions - memory
loadByte: instruction
	| base address value |
	base := self unsignedRegister: instruction rs.
	address := base + instruction signedImmediate.
	value := self signedByte: address.
	self signedRegister: instruction rt put: value.