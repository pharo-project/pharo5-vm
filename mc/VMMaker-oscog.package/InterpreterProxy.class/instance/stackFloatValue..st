stack access
stackFloatValue: offset
	| oop |
	<returnTypeC: 'double'>
	oop := self stackValue: offset.
	(self isFloatObject: oop) ifFalse: [self primitiveFail. ^0.0].
	^oop