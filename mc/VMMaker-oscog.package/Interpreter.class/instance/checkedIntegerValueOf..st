utilities
checkedIntegerValueOf: intOop
	"Note: May be called by translated primitive code."

	(self isIntegerObject: intOop)
		ifTrue: [ ^ self integerValueOf: intOop ]
		ifFalse: [ self primitiveFail. ^ 0 ]