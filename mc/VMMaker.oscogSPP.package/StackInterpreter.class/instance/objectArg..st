plugin primitive support
objectArg: index
	"Like #stackObjectValue: but access method arguments left-to-right"
	| oop |
	oop := self methodArg: index.
	oop = 0 ifTrue:[^0]. "methodArg: failed"
	(objectMemory isImmediate: oop) ifTrue: [self primitiveFail. ^ nil].
	^oop