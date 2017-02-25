other primitives
primitiveGetAttribute
	"Fetch the system attribute with the given integer ID. The result is a string, which will be empty if the attribute is not defined."

	| attr s attribute |
	attr := self stackIntegerValue: 0.
	successFlag ifTrue: [
		attribute := Smalltalk vm getSystemAttribute: attr.
		attribute ifNil: [ ^self primitiveFail ].
		s := self instantiateClass: (self splObj: ClassByteString) indexableSize: attribute size.
		1 to: attribute size do: [ :i |
			self storeByte: i-1 ofObject: s withValue: (attribute at: i) asciiValue].
		self pop: 2  "rcvr, attr" thenPush: s].
