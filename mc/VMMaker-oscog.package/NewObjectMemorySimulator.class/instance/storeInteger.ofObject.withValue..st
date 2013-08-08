simulation only
storeInteger: fieldIndex ofObject: objectPointer withValue: integerValue
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter storeInteger: fieldIndex ofObject: objectPointer withValue: integerValue