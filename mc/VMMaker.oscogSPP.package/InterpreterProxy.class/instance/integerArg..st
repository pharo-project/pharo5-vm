stack access
integerArg: offset
	"Like #stackIntegerValue: but access method arguments left-to-right"
	| oop |
	oop := self methodArg: offset.
	(self isIntegerObject: oop) ifFalse: [self primitiveFail. ^0].
	^oop