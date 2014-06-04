stack access
stackObjectValue: offset
	| oop |
	oop := self stackValue: offset.
	(self isImmediate: oop) ifTrue: [self primitiveFail. ^ nil].
	^oop