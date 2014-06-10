debug printing
printMethodCacheFor: thing
	<api>
	0 to: MethodCacheSize - 1 by: MethodCacheEntrySize do:
		[:i | | s c m p |
		s := methodCache at: i + MethodCacheSelector.
		c := methodCache at: i + MethodCacheClass.
		m := methodCache at: i + MethodCacheMethod.
		p := methodCache at: i + MethodCachePrimFunction.
		((thing = -1 or: [s = thing or: [c = thing or: [p = thing or: [m = thing]]]])
		 and: [(objectMemory addressCouldBeOop: s)
		 and: [c ~= 0
		 and: [(self addressCouldBeClassObj: c)
			or: [self addressCouldBeClassObj: (objectMemory classForClassTag: c)]]]]) ifTrue:
			[self cCode: [] inSmalltalk: [self transcript ensureCr].
			 self printNum: i; cr; tab.
			 (objectMemory isBytesNonImm: s)
				ifTrue: [self cCode: 'printf("%x %.*s\n", s, byteLengthOf(s), (char *)firstIndexableField(s))'
						inSmalltalk: [self printHex: s; space; print: (self stringOf: s); cr]]
				ifFalse: [self shortPrintOop: s].
			 self tab.
			 (self addressCouldBeClassObj: c)
				ifTrue: [self shortPrintOop: c]
				ifFalse: [self printNum: c; space; shortPrintOop: (objectMemory classForClassTag: c)].
			self tab; shortPrintOop: m; tab.
			self cCode:
					[p > 1024
						ifTrue: [self printHexnp: p]
						ifFalse: [self printNum: p]]
				inSmalltalk:
					[p isSymbol ifTrue: [self print: p] ifFalse: [self printNum: p]].
			self cr]]