stack access
floatArg: offset
	"Like #stackFloatValue: but access method arguments left-to-right"
	| oop |
	<returnTypeC: 'double'>
	oop := self methodArg: offset.
	(self isFloatObject: oop) ifFalse: [self primitiveFail. ^0.0].
	^oop