stack bytecodes
storeAndPopRemoteTempLongBytecode
	self storeRemoteTempLongBytecode.
	self internalPop: 1