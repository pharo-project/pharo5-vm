simulation only
fetchInteger: fieldIndex ofObject: objectPointer
	"hack around the CoInterpreter/ObjectMemory split refactoring"
	^coInterpreter fetchInteger: fieldIndex ofObject: objectPointer