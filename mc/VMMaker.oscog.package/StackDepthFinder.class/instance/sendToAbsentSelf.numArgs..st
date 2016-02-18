instruction decoding
sendToAbsentSelf: selector numArgs: numArgs
	self drop: numArgs - 1 "e.g. if no args pushes a result"