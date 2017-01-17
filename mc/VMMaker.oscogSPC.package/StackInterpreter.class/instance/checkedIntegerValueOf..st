utilities
checkedIntegerValueOf: intOop
	"Note: May be called by translated primitive code."

	(objectMemory isIntegerObject: intOop)
		ifTrue: [ ^ objectMemory integerValueOf: intOop ]
		ifFalse: [ self primitiveFail. ^ 0 ]