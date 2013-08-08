stack access
stackObjectValue: offset
	| oop |
	oop := self stackValue: offset.
	(self isIntegerObject: oop) ifTrue: [self primitiveFail. ^ nil].
	^oop