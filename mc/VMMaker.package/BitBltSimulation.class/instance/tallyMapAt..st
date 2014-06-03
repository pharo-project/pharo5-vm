memory access
tallyMapAt: idx
	"Return the word at position idx from the colorMap"
	^cmLookupTable at: (idx bitAnd: cmMask)