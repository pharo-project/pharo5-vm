internal interpreter access
internalPush: object

	self longAtPointer: (localSP := localSP + BytesPerWord) put: object.