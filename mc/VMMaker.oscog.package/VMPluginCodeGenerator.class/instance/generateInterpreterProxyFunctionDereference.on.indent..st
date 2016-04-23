C translation
generateInterpreterProxyFunctionDereference: aNode on: aStream indent: anInteger
	| pluginsToClone |
	pluginsToClone := self pluginFunctionsToClone copyWithoutAll: self selectorsThatAreGeneratedAsMacros.
	pluginsToClone isEmpty ifTrue:
		[^self].
	aStream cr; nextPutAll: '#if !defined(SQUEAK_BUILTIN_PLUGIN)'; cr.
	pluginsToClone do:
		[:s| | cs |
		cs := self cFunctionNameFor: s.
		self withOptionalVerbiageFor: s
			on: aStream
			do: [aStream tab: anInteger; nextPutAll: cs; nextPutAll: ' = interpreterProxy->'; nextPutAll: cs; nextPut: $;; cr]
			ifOptionalDo: [aStream
							nextPutAll: '# if !defined('; nextPutAll: cs; nextPut: $);
							crtab: anInteger; nextPutAll: cs; nextPutAll: ' = 0;';
							cr; nextPutAll: '# endif'; cr]].
	aStream nextPutAll: '#endif /* !defined(SQUEAK_BUILTIN_PLUGIN) */'.