as yet unclassified
printOn: stream
	stream nextPutAll: self class name; nextPut: $:; cr.
	self printRegistersOn: stream.
	stream nextPutAll: self currentInstruction.