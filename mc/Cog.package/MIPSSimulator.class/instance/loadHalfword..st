instructions - memory
loadHalfword: instruction
	| base address value |
	base := self unsignedRegister: instruction rs.
	address := base + instruction signedImmediate.
	value := self signedHalfword: address.
	self signedRegister: instruction rt put: value.