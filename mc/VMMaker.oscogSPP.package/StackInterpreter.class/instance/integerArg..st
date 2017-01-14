plugin primitive support
integerArg: index
	"Like #stackIntegerValue: but access method arguments left-to-right"
	| oop |
	oop := self methodArg: index.
	oop = 0 ifTrue:[^0]. "methodArg: failed"
	^self checkedIntegerValueOf: oop