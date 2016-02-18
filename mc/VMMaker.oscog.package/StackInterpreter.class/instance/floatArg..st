plugin primitive support
floatArg: index
	"Like #stackFloatValue: but access method arguments left-to-right"
	| oop |
	<returnTypeC: #double>
	oop := self methodArg: index.
	oop = 0 ifTrue:[^0.0]. "methodArg: failed"
	^objectMemory floatValueOf: oop