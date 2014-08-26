bootstrap methods
cloneMethodProxy: proxy "<VMCompiledMethodProxy>"
	| bytes newMethod delta |
	bytes := proxy size - proxy initialPC + 1.
	delta := proxy primitive > 0
				ifTrue: [3]
				ifFalse: [0].
	newMethod := CompiledMethod
						newMethod: bytes + delta
						header: (self headerForOldMethodHeader: (oldHeap integerObjectOf: proxy header)).
	1 to: proxy numLiterals - 1 do:
		[:i| newMethod literalAt: i put: (proxy literalAt: i)].
	newMethod
		literalAt: proxy numLiterals
		put: (Smalltalk bindingOf: #Character).
	delta > 0 ifTrue:
		[newMethod
			at: newMethod initialPC + 0 put: 139;
			at: newMethod initialPC + 1 put: (proxy primitive bitAnd: 16rFF);
			at: newMethod initialPC + 2 put: (proxy primitive bitShift: -8)].
	proxy initialPC to: proxy size do:
		[:i| newMethod at: i + delta put: (proxy at: i)].
	^newMethod