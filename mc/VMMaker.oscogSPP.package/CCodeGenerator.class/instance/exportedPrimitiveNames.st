public
exportedPrimitiveNames
	"Return an array of all exported primitives"
	^methods select:[:m| m export] thenCollect:[:m| self cFunctionNameFor: m selector].
