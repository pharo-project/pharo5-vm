C translation
emitIfdefForPluginFunctionOption: anArrayOrSymbol on: aStream
	"See e.g. senders of atLeastVMProxyMajor:minor: or <option: #IMMUTABLITY>
	 in InterpreterProxy"
	aStream nextPutAll: '#if '; nextPutAll: (anArrayOrSymbol isSymbol
											ifTrue: [anArrayOrSymbol]
											ifFalse: [self perform: anArrayOrSymbol first
														withArguments: anArrayOrSymbol allButFirst])