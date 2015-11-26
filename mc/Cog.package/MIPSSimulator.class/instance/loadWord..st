instructions - memory
loadWord: instruction
	| base address value |
	base := self unsignedRegister: instruction rs.
	address := base + instruction signedImmediate.
	value := self signedWord: address.
	self signedRegister: instruction rt put: value.