stack access
objectArg: offset
	"Like #stackObjectValue: but access method arguments left-to-right"
	| oop |
	oop := self methodArg: offset.
	(self isIntegerObject: oop) ifTrue: [self primitiveFail. ^ nil].
	^oop