private
interpreter: interpreterSimulator address: arrayAddress unitSize: numBytes

	interpreter := interpreterSimulator.
	arrayBaseAddress := arrayAddress.
	self unitSize: numBytes.
	ptrOffset := 0