stack access
stackIntegerValue: offset
	| oop |
	oop := self stackValue: offset.
	(self isIntegerObject: oop) ifFalse: [self primitiveFail. ^0].
	^oop