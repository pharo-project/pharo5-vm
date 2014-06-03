utilities
storeInteger: fieldIndex ofObject: objectPointer withValue: integerValue 
	"Note: May be called by translated primitive code."
	(objectMemory isIntegerValue: integerValue)
		ifTrue: [objectMemory storePointerUnchecked: fieldIndex ofObject: objectPointer
					withValue: (objectMemory integerObjectOf: integerValue)]
		ifFalse: [self primitiveFail].
	^nil