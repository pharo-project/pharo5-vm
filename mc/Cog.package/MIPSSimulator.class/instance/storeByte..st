instructions - memory
storeByte: instruction
	| base address value |
	base := self unsignedRegister: instruction rs.
	address := base + instruction signedImmediate.
	value := (self signedRegister: instruction rt) bitAnd: 16rFF.
	self unsignedByte: address put: value.