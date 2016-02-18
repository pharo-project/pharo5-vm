instructions - memory
loadHalfwordUnsigned: instruction
	| base address value |
	base := self unsignedRegister: instruction rs.
	address := base + instruction signedImmediate.
	value := self unsignedHalfword: address.
	self unsignedRegister: instruction rt put: value.