C translation
emitIfdefForPluginFunctionOption: anArray on: aStream 
	aStream nextPutAll: '#if '; nextPutAll: (self perform: anArray first withArguments: anArray allButFirst)