instructions - memory
storeHalfword: instruction
	| base address value |
	base := self unsignedRegister: instruction rs.
	address := base + instruction signedImmediate.
	value := (self signedRegister: instruction rt) bitAnd: 16rFFFF.
	self unsignedHalfword: address put: value.