instructions - arithmetic
multiplySigned: instruction
	| rsValue rtValue result |
	rsValue := self signedRegister: instruction rs.
	rtValue := self signedRegister: instruction rt.
	result := rsValue * rtValue.
	result := self signed64ToUnsigned64: result.
	hi := self unsigned32ToSigned32: result >> 32.
	lo := self unsigned32ToSigned32: (result bitAnd: 16rFFFFFFFF).