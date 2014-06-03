system primitives
primitiveCurrencySymbol
	"return a string describing the currency symbol used 
Still need to find details on standard symbols - ISO 4217 is supposed to be it but cannot find on web"
	| oop length |
	self primitive:'primitiveCurrencySymbol'.
	length := self sqLocCurrencySymbolSize.
	oop := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: length.
	self sqLocGetCurrencySymbolInto: (interpreterProxy firstIndexableField: oop).
	^oop
