system primitives
primitiveDigitGroupingSymbol
	"return a 1 char string describing the digitGrouping symbol used - usually a . or a , between triples of digits"
	| oop |
	self primitive:'primitiveDigitGroupingSymbol'.
	oop := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: 1.
	self sqLocGetDigitGroupingSymbolInto: (interpreterProxy firstIndexableField: oop).
	^oop
