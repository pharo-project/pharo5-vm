system primitives
primitiveCurrencyNotation
	"return a boolean specifying whether the currency symbol is pre or post fix. true -> pre"
	self primitive:'primitiveCurrencyNotation'.
	^self sqLocCurrencyNotation asOop: Boolean