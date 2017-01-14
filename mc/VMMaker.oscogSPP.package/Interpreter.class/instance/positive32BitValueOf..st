primitive support
positive32BitValueOf: oop
	"Convert the given object into an integer value.
	The object may be either a positive ST integer or a four-byte LargePositiveInteger."

	| sz value |
	(self isIntegerObject: oop) ifTrue: [
		value := self integerValueOf: oop.
		value < 0 ifTrue: [^ self primitiveFail].
		^ value].

	self assertClassOf: oop is: (self splObj: ClassLargePositiveInteger).
	successFlag ifTrue: [
		sz := self lengthOf: oop.
		sz = 4 ifFalse: [^ self primitiveFail]].
	successFlag ifTrue: [
		^ (self fetchByte: 0 ofObject: oop) +
		  ((self fetchByte: 1 ofObject: oop) <<  8) +
		  ((self fetchByte: 2 ofObject: oop) << 16) +
		  ((self fetchByte: 3 ofObject: oop) << 24) ].