bootstrap methods
cloneMethodProxy: proxy "<VMCompiledMethodProxy>"
	| bytes newMethod |
	bytes := proxy size - proxy initialPC + 1.
	newMethod := CompiledMethod
						newMethod: bytes
						header: proxy header.
	1 to: proxy numLiterals - 1 do:
		[:i| newMethod literalAt: i put: (proxy literalAt: i)].
	newMethod
		literalAt: proxy numLiterals
		put: (Smalltalk bindingOf: #Character).
	proxy initialPC to: proxy size do:
		[:i| newMethod at: i put: (proxy at: i)].
	^newMethod