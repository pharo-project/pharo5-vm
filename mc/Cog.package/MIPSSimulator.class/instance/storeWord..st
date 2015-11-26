instructions - memory
storeWord: instruction
	| base address value |
	base := self unsignedRegister: instruction rs.
	address := base + instruction signedImmediate.
	value := self signedRegister: instruction rt.
	self signedWord: address put: value.