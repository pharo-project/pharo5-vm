memory access
tallyMapAt: idx put: value
	"Store the word at position idx in the colorMap"
	^cmLookupTable at: (idx bitAnd: cmMask) put: value