instruction decoding
sendToAbsentOuter: selector numArgs: numArgs depth: depth
	self drop: numArgs - 1 "e.g. if no args pushes a result"