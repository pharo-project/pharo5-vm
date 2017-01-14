system primitives
primitiveDecimalSymbol
	"return a 1 char string describing the decimal symbol used - usually a . or a ,"
	| oop |
	self primitive:'primitiveDecimalSymbol'.
	oop := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: 1.
	self sqLocGetDecimalSymbolInto: (interpreterProxy firstIndexableField: oop).
	^oop
