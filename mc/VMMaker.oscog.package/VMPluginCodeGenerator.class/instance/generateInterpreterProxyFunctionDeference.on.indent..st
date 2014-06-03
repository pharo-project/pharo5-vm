C translation
generateInterpreterProxyFunctionDeference: aNode on: aStream indent: anInteger
	| pluginsToClone |
	(pluginsToClone := self pluginFunctionsToClone) isEmpty ifTrue:
		[^self].
	aStream cr; nextPutAll: '#if !defined(SQUEAK_BUILTIN_PLUGIN)'.
	pluginsToClone do:
		[:s| | cs |
		cs := self cFunctionNameFor: s.
		self withOptionalVerbiageFor: s
			on: aStream
			do: [aStream crtab: anInteger; nextPutAll: cs; nextPutAll: ' = interpreterProxy->'; nextPutAll: cs; nextPut: $;]
			ifOptionalDo: [aStream crtab: anInteger; nextPutAll: cs; nextPutAll: ' = 0;']].
	aStream cr; nextPutAll: '#endif /* !defined(SQUEAK_BUILTIN_PLUGIN) */'.