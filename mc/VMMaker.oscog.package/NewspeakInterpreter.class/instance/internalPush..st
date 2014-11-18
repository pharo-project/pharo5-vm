internal interpreter access
internalPush: object

	self longAtPointer: (localSP := localSP + self wordSize) put: object.